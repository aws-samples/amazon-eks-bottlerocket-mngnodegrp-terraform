
#######################Addons-node-group

 locals {
worker-mng-name = "${var.name}-mng-worker-${random_string.worker-mng-name.result}"
 }

resource "random_string" "worker-mng-name" {
  length  = 4
  upper   = false
  number  = true
  lower   = true
  special = false
}

resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = var.name
  node_group_name = local.worker-mng-name
  node_role_arn   = aws_iam_role.managed_workers.arn
  #subnet_ids      = values(var.vpc_config.private_subnet_ids)
  subnet_ids      = concat(sort(data.aws_subnet_ids.private.ids))

  launch_template {
   name = aws_launch_template.bottlerocket_lt.name
   version = aws_launch_template.bottlerocket_lt.latest_version
}

  scaling_config {
    desired_size = var.worker_desired_size
    max_size     = var.worker_max_size
    min_size     = var.worker_min_size
  }

depends_on = [aws_launch_template.bottlerocket_lt,
             aws_eks_cluster.cluster,
             local_file.aws_auth_configmap
]
lifecycle {
    create_before_destroy = true
  }
}

