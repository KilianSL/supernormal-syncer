provider "aws" {
  region = var.aws_region
}

# VPC for the EC2 instance
resource "aws_vpc" "api_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.api_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "api_igw" {
  vpc_id = aws_vpc.api_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.api_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.api_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Route table association
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security group for API
resource "aws_security_group" "api_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for API"
  vpc_id      = aws_vpc.api_vpc.id

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  # Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  # Allow SSH traffic for management
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ip}/32"]
    description = "SSH from admin IP"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# EC2 instance for API
resource "aws_instance" "api_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.api_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Setting up the server..."
              # Update packages
              apt-get update -y
              apt-get upgrade -y

              # Install Node.js and npm
              curl -fsSL https://fnm.vercel.app/install | bash
              source ~/.bashrc
              fnm install 16
              fnm use 16

              # Install pnpm
              npm install -g pnpm

              # Install Docker (for local development)
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker

              # Clone the repository and set up the application
              mkdir -p /opt/api
              echo "Setup complete!"
              EOF

  tags = {
    Name = "${var.project_name}-instance"
  }
}

# Elastic IP for the instance
resource "aws_eip" "api_eip" {
  instance = aws_instance.api_instance.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}

# Output the public IP of the instance
output "api_public_ip" {
  value = aws_eip.api_eip.public_ip
} 