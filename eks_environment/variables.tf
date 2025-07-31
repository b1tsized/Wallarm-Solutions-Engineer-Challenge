variable "region" {
  type = string
  default = "us-east-1"
  description = "Default AWS Region."
}

variable "profile" {
    type = string
    description = "AWS profile you'd like to proxy for running Terraform."
}