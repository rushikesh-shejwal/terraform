output "subnet_private" {
  value = aws_subnet.private_subnet
}

output "subnet_public" {
  value = aws_subnet.public_subent
}

output "my-vpc" {
  value = aws_vpc.my_vpc
}