# resource "aws_nat_gateway" "ng" {
#   allocation_id = aws_eip.ng_eip.id
#   subnet_id     = aws_subnet.bastion_public_subnet.id

#   tags = {
#     Name = "${var.product}-${var.env}-ng"
#   }
# }

# resource "aws_eip" "ng_eip" {
#   vpc = true
#   tags = {
#     Name = "${var.product}-${var.env}-ng-eip"
#   }
# }

# resource "aws_route" "ng_to_private_route_table" {
#   route_table_id         = aws_route_table.private_route_table.id
#   destination_cidr_block = var.ipv4_quad_zero_route
#   nat_gateway_id         = aws_nat_gateway.ng.id
#   depends_on             = [aws_route_table.private_route_table]
# }
