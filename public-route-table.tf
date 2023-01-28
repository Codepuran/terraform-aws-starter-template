# Public Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "public_route_table" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc, aws_internet_gateway.ig]
  tags = {
    Name = "${var.product}-${var.env}-public-rt"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "ig_to_public_route_table" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.ipv4_quad_zero_route
  gateway_id             = aws_internet_gateway.ig.id
  depends_on             = [aws_route_table.public_route_table]
}
