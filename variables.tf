variable "env" {
  description = "env"
  type        = string
}

variable "product" {
  description = "product"
  type        = string
}

variable "aws_region" {
  description = "aws_region"
  type        = string
}

variable "aws_profile" {
  description = "aws_profile"
  type        = string
}

variable "vpc_cidr_block" {
  description = "vpc_cidr_block"
  type        = string
}

variable "vpc_instance_tenancy" {
  description = "vpc_instance_tenancy"
  type        = string
}

variable "ipv4_quad_zero_route" {
  description = "ipv4_quad_zero_route"
  type        = string
}

variable "ipv6_all_network_route" {
  description = "ipv6_all_network_route"
  type        = string
}

variable "bastion_cidr_block" {
  description = "bastion_cidr_block"
  type        = string
}

variable "bastion_subnet_availability_zone" {
  description = "bastion_subnet_availability_zone"
  type        = string
}

variable "bastion_ami" {
  description = "bastion_ami"
  type        = string
}

variable "bastion_instance_type" {
  description = "bastion_instance_type"
  type        = string
}

variable "bastion_key_pair_name" {
  description = "bastion_key_pair_name"
  type        = string
}

variable "bastion_disable_api_termination" {
  description = "bastion_disable_api_termination"
  type        = bool
}

variable "bastion_ebs_encrypted" {
  description = "bastion_ebs_encrypted"
  type        = bool
}

variable "bastion_ebs_volume_size" {
  description = "bastion_ebs_volume_size"
  type        = number
}

variable "bastion_ebs_delete_on_termination" {
  description = "bastion_ebs_delete_on_termination"
  type        = bool
}

variable "availability_zones_n_instances" {
  description = "availability_zones_n_instances map"
  type        = map(any)
}
