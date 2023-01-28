resource "aws_security_group" "alb_sg" {
  name        = "${var.product}-${var.env}-api-alb-sg"
  description = "${var.product}-${var.env}-api-alb-sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.ipv4_quad_zero_route]
    ipv6_cidr_blocks = [var.ipv6_all_network_route]
  }

  ingress {
    description      = "HTTPS Web traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.ipv4_quad_zero_route]
    ipv6_cidr_blocks = [var.ipv6_all_network_route]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.ipv4_quad_zero_route]
    ipv6_cidr_blocks = [var.ipv6_all_network_route]
  }

  tags = {
    Name = "${var.product}-${var.env}-api-alb-sg"
  }
}
