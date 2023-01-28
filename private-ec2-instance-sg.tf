resource "aws_security_group" "private_instance_sg" {
  name        = "${var.product}-${var.env}-private-instance-sg"
  description = "${var.product}-${var.env}-private-instance-sg"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${var.product}-${var.env}-private-instance-sg"
  }
}

resource "aws_security_group_rule" "allow_ssh_from_bastion_subnet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.bastion_cidr_block] #TODO specific bastion ip for more security
  security_group_id = aws_security_group.private_instance_sg.id
}

resource "aws_security_group_rule" "allow_internet_access_to_private_instances" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.ipv4_quad_zero_route]
  ipv6_cidr_blocks  = [var.ipv6_all_network_route]
  security_group_id = aws_security_group.private_instance_sg.id
}
