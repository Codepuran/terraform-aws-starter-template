resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.subnets_az

  tags = {
    Environment = var.env
    App         = var.product
    Name        = "${var.product}-${var.env}-private-subnet-${var.subnets_az}"
  }
}

resource "aws_route_table_association" "private_route_table_association_with_private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = var.private_route_table_id

  depends_on = [
    aws_subnet.private_subnet
  ]
}
