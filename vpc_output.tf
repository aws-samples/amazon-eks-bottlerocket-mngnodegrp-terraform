output "vpc_network_id" {
  value = aws_vpc.eks_network.id
}
output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}


