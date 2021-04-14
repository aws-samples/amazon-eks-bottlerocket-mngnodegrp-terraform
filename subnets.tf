data "aws_availability_zones" "available" {}


resource "aws_subnet" "public" {
  count = var.az_counts

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  vpc_id                  = aws_vpc.eks_network.id
  map_public_ip_on_launch = true

  tags = {
    Name                             = "${var.name}-public-${data.aws_availability_zones.available.names[count.index]}"
    "kubernetes.io/role/elb"         = "1"
    "kubernetes.io/role/alb-ingress" = "1"
    "subnet-type"             = "public"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "aws_route_table_association" "public" {
   count = var.az_counts

   subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.eks_network_public.id
}

# Private subnets
resource "aws_subnet" "private" {
   count = var.az_counts

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + 20)
  vpc_id                  = aws_vpc.eks_network.id
  map_public_ip_on_launch = false

  tags = {
    Name                              = "${var.name}-private-${data.aws_availability_zones.available.names[count.index]}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/role/alb-ingress"  = "1"
    "subnet-type"             = "private"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}


resource "aws_nat_gateway" "eks_network_nat_gateway" {
  allocation_id = aws_eip.eks_network_nat_gateway.id
  subnet_id      = aws_subnet.public.*.id[0]

  tags = {
    Name = var.name
  }
}

resource "aws_route" "nat-gateway" {
  route_table_id         = aws_default_route_table.eks_network_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.eks_network_nat_gateway.id
}

resource "aws_route_table_association" "private" {
  count = var.az_counts

  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_default_route_table.eks_network_private.id
}
