provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Allow dynamic ports"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "ec2" {
  count         = 2
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.instance_sg.id
  ]
  tags = {
    Name = "ec2-${count.index + 1}"
  }

  user_data = templatefile(
    "${path.module}/cloud-init.yaml.tpl",
    {
      ctfd_yaml_base64 = base64encode(file("${path.module}/../.ctfd.yaml"))
    }
  )
}

output "instance_public_ips" {
  value = aws_instance.ec2[*].public_ip
}


