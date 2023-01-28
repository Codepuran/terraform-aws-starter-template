resource "aws_subnet" "public_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.subnets_az

  tags = {
    Environment = var.env
    App         = var.product
    Name        = "${var.product}-${var.env}-public-subnet-${var.subnets_az}"
  }
}

resource "aws_route_table_association" "public_route_table_association_with_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = var.public_route_table_id

  depends_on = [
    aws_subnet.public_subnet
  ]
}
