resource "aws_vpc" "eks_network" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# Internet gateway
resource "aws_internet_gateway" "eks_network_gateway" {
  vpc_id = aws_vpc.eks_network.id

  tags = {
    Name = var.name
  }
}

# NAT gateway
resource "aws_eip" "eks_network_nat_gateway" {
  vpc        = true
  depends_on = [aws_internet_gateway.eks_network_gateway]

  tags = {
    Name = "${var.name}-nat-gateway"
  }
}

resource "aws_route_table" "eks_network_public" {
  vpc_id = aws_vpc.eks_network.id

  tags = {
    Name = "${var.name}-public"
  }
}

resource "aws_route" "internet-gateway" {
  route_table_id         = aws_route_table.eks_network_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks_network_gateway.id
}

resource "aws_default_route_table" "eks_network_private" {
  default_route_table_id = aws_vpc.eks_network.default_route_table_id

  tags = {
    Name = "${var.name}-private"
  }
}
