variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "allowed_ports" {
  description = "List of ports to allow in the security group"
  type        = list(number)
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
}