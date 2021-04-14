output "vpc_network_id" {
  value = aws_vpc.eks_network.id
}
output "private_subnet_id" {
  value          = [for az, subnet in aws_subnet.private: subnet.id]
}
output "public_subnet_id" {
  value          = [for az, subnet in aws_subnet.public: subnet.id]
}
