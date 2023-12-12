data "aws_vpc" "network" {
  id = aws_vpc.eks_network.id
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:subnet-type"
    values = ["private"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:subnet-type"
    values = ["public"]
  }
}

resource "aws_security_group" "control_plane" {
  count = var.legacy_security_groups ? 1 : 0

  name        = "eks-control-plane-${var.name}"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.eks_network.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-control-plane-${var.name}"
  }
}

resource "aws_eks_cluster" "cluster" {
  enabled_cluster_log_types = []
  name                      = var.name
  role_arn                  = aws_iam_role.cluster_role.arn
  version                   = var.eks_version
  vpc_config {
    subnet_ids              = concat(sort(data.aws_subnets.private.ids), sort(data.aws_subnets.public.ids))
    security_group_ids      = aws_security_group.control_plane.*.id
    endpoint_private_access = "true"
    endpoint_public_access  = "true"
  }
  tags = var.tags
  depends_on = [
    aws_iam_role.cluster_role,
    aws_iam_role.managed_workers,
    aws_cloudwatch_log_group.cluster,
    aws_nat_gateway.eks_network_nat_gateway
  ]

  provisioner "local-exec" {
    command     = "until curl --output /dev/null --insecure --silent ${self.endpoint}/healthz; do sleep 1; done"
    working_dir = path.module
  }

}
resource "aws_cloudwatch_log_group" "cluster" {
  name              = "/aws/eks/${var.name}/cluster"
  retention_in_days = var.log_retention
}
