module "subnets_in_azs" {

  for_each = var.availability_zones_n_instances

  source = "./modules/subnets-in-azs"

  env                       = var.env
  product                   = var.product
  subnets_az                = each.key
  index                     = each.value.index
  public_subnet_cidr_block  = each.value.public_subnet_cidr_block
  private_subnet_cidr_block = each.value.private_subnet_cidr_block

  vpc_id                 = aws_vpc.vpc.id
  public_route_table_id  = aws_route_table.public_route_table.id
  private_route_table_id = aws_route_table.private_route_table.id


  depends_on = [
    aws_vpc.vpc
  ]
}
