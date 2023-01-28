# VPC

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC Id"
}

output "vpc_arn" {
  value       = aws_vpc.vpc.arn
  description = "VPC arn"
}

output "vpc_cidr" {
  value       = aws_vpc.vpc.cidr_block
  description = "VPC CIDR"
}

# Internet Gateway

output "ig_id" {
  value       = aws_internet_gateway.ig.id
  description = "Internet Gateway Id"
}

output "ig_arn" {
  value       = aws_internet_gateway.ig.id
  description = "Internet Gateway arn"
}

# Public Route Table

output "public_route_table_id" {
  value       = aws_route_table.public_route_table.id
  description = "Public Route Table Id"
}

output "public_route_table_arn" {
  value       = aws_route_table.public_route_table.arn
  description = "Public Route Table arnd"
}
output "aws_managed_default_kms_key_arn" {
  value       = data.aws_ebs_default_kms_key.current.key_arn
  description = "aws managed default kms key arn"
}
output "bastion_host_id" {
  value       = aws_instance.bastion_host.id
  description = "bastion_host_id"
}

output "bastion_host_eip" {
  value = aws_eip.bastion_host_eip.public_ip
}
