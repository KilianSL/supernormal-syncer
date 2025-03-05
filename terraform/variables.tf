variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "The name of the project, used for resource naming"
  type        = string
  default     = "typescript-node-api"
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0e5f882be1900e43b" # Ubuntu 20.04 LTS for eu-west-2 (London)
}

variable "key_name" {
  description = "The name of the key pair for SSH access"
  type        = string
}

variable "admin_ip" {
  description = "The IP address allowed for SSH access"
  type        = string
  sensitive   = true
  # No default, must be provided
} 