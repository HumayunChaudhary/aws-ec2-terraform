provider "aws" {
  region = "eu-north-1"
}

data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group" "test_laravel_app_SG" {
  name        = "test_laravel_app-SG"
  description = "This SG is for EC2 test_laravel_app"
  vpc_id      = data.aws_vpc.default_vpc.id
  tags = {
    Name = "test_laravel_app-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rule" {
  security_group_id = aws_security_group.test_laravel_app_SG.id
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "outbound_rule" {
  security_group_id = aws_security_group.test_laravel_app_SG.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_key_pair" "test_laravel_app_key" {
  key_name   = "key_terraform-VM"
  public_key = file("key_terraform-VM.pub")
}

resource "aws_instance" "test_laravel_app" {
  instance_type          = "t3.micro"
  ami                    = "ami-067bcf851477ebb78"
  key_name               = aws_key_pair.test_laravel_app_key.key_name
  vpc_security_group_ids = [aws_security_group.test_laravel_app_SG.id]
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "test_laravel_app"
  }
}
