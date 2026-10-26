variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix used to name project resources"
  type        = string
  default     = "secure-three-tier"
}

variable "vpc_cidr" {
  description = "IPv4 range for the VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the demo database"
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  description = "Demo database password; supply securely via TF_VAR_db_password"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}
