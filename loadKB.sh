#!/bin/sh
echo "set read only = ${NEOREADONLY} then launch neo4j service"
sed -i s/read_only=.*/read_only=${NEOREADONLY}/ ${NEOSERCONF} && \

echo 'Allow new plugin to make changes..'
echo 'dbms.security.procedures.unrestricted=ebi.spot.neo4j2owl.*,apoc.*,gds.*' >> ${NEOSERCONF}

if [ -n "${BACKUPFILE}" ]; then
  if [ ! -d /data/databases/neo4j ]; then
    # Download backup
    if [ ! -f /backup/neo4j.dump ]; then
      echo 'Restore KB from archive backup'
      # mkdir backup && cd backup # works if you want to wget the backup
      cd /backup/
      wget http://data.virtualflybrain.org/archive/${BACKUPFILE}
      cd -
    fi
    
    # Restore from backup
    echo 'Restore KB from given backup'
    # /var/lib/neo4j/bin/neo4j-admin load --from=/backup/${BACKUPFILE} --verbose --force    # if you want to wget the backup
    /var/lib/neo4j/bin/neo4j-admin load --from=/backup/${BACKUPFILE} --verbose --force
  fi
fi

echo -e '\nSTARTING VFB KB SERVER\n' >> /var/lib/neo4j/logs/query.log

#Output the query log to docker log:
tail -f /var/lib/neo4j/logs/query.log >/proc/1/fd/1 &
exec /docker-entrypoint.sh neo4j
