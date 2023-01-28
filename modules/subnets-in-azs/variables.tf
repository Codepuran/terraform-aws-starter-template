variable "env" {
  description = "env"
  type        = string
}

variable "product" {
  description = "product"
  type        = string
}

variable "index" {
  description = "Index of module execution"
  type        = number
}

variable "subnets_az" {
  description = "Name of Avaibility Zone for Subnets"
  type        = string
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "public_route_table_id" {
  description = "public_route_table_id"
  type        = string
}

variable "private_route_table_id" {
  description = "private_route_table_id"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "public_subnet_cidr_block"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "private_subnet_cidr_block"
  type        = string
}
