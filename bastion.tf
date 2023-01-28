# EC2 Bastion host
# Retrieving aws managed kms key for current region
data "aws_ebs_default_kms_key" "current" {}

# https://github.com/hashicorp/terraform-provider-aws/issues/15137#issuecomment-691730866
data "aws_kms_key" "current" {
  key_id = data.aws_ebs_default_kms_key.current.key_arn
}
resource "aws_instance" "bastion_host" {
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id     = aws_subnet.bastion_public_subnet.id

  # Time being turning off this feature for debugging issue with recreation
  disable_api_termination = var.bastion_disable_api_termination
  key_name                = var.bastion_key_pair_name
  vpc_security_group_ids  = [aws_security_group.allow_ssh_bastion.id]
  root_block_device {
    encrypted             = var.bastion_ebs_encrypted
    kms_key_id            = data.aws_kms_key.current.arn
    volume_size           = var.bastion_ebs_volume_size
    delete_on_termination = var.bastion_ebs_delete_on_termination
    tags = {
      Environment = var.env
      App         = var.product
      Name        = "${var.product}-${var.env}-bastion-root-ebs"
    }
  }

  depends_on = [
    aws_subnet.bastion_public_subnet,
    aws_security_group.allow_ssh_bastion
  ]

  tags = {
    Name = "${var.product}-${var.env}-bastion"
  }
}

resource "aws_eip" "bastion_host_eip" {
  instance = aws_instance.bastion_host.id
  vpc      = true
  tags = {
    Name = "${var.product}-${var.env}-bastion-eip"
  }
}

resource "aws_security_group" "allow_ssh_bastion" {
  name        = "${var.product}-${var.env}-bastion-sg"
  description = "${var.product}-${var.env}-bastion-sg"
  vpc_id      = aws_vpc.vpc.id

  #   ingress {
  #     description      = "SSH from Internet"
  #     from_port        = 22
  #     to_port          = 22
  #     protocol         = "tcp"
  #     cidr_blocks      = [var.ipv4_quad_zero_route]
  #     ipv6_cidr_blocks = [var.ipv6_all_network_route]
  #   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.ipv4_quad_zero_route]
    ipv6_cidr_blocks = [var.ipv6_all_network_route]
  }

  tags = {
    Name = "${var.product}-${var.env}-bastion-sg"
  }
}

# Bastion Subnet
resource "aws_subnet" "bastion_public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.bastion_cidr_block
  availability_zone = var.bastion_subnet_availability_zone

  depends_on = [
    aws_vpc.vpc
  ]
  tags = {
    Name = "${var.product}-${var.env}-bastion-public-subnet"
  }
}

resource "aws_route_table_association" "public_route_table_association_bastion_public_subnet" {
  subnet_id      = aws_subnet.bastion_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id

  depends_on = [
    aws_subnet.bastion_public_subnet,
    aws_route_table.public_route_table
  ]
}
