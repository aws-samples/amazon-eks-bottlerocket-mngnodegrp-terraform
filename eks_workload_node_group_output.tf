output "node_group_name" {
  value = aws_eks_node_group.worker-node-group.node_group_name
}
output "worker_desired_size" {
  value = var.worker_desired_size
}
output "worker_max_size" {
  value = var.worker_max_size
}
output "worker_min_size" {
  value = var.worker_min_size
}
