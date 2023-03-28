variable "project_name" {
  description = "Name of project."
  type        = string
  default     = "knowledge-graph-ebi"
  validation {
    condition     = length(var.project_name) < 42
    error_message = "Maximum length for project name is 41."
  }
}

variable "domain_name" {
  description = "Domain name registered from AWS Route 53 used as basename for the API URL to the deployed service."
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "github_oauth_token" {
  description = "OAuth token allowing access to repository."
  type        = string
  sensitive   = true
}

variable "github_branch" {
  description = "GitHub git branch."
  type        = string
}

variable "docker_username" {
  description = "User name for Docker account to use during build."
  type        = string
}

variable "docker_login_token" {
  description = "Docker login token for Docker account used in build."
  type        = string
  sensitive   = true
}

variable "github_username" {
  description = "GitHub service account username. "
  type        = string
}

variable "github_access_token" {
  description = "GitHub personal access token for nuget package access."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "AWS region where service is deployed."
  type        = string
  default     = "us-west-2"
}

variable "web_app_domain" {
  description = "The web app domain"
  type        = string
  default     = ""
}

variable "docker_image" {
  description = "The image from Docker Hub to deploy."
  type        = string
  default     = ""
}
