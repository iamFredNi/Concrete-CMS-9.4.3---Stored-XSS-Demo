output "main_vpc" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "main_igw_id" {
  value = aws_internet_gateway.main_igw.id
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}

output "ssh_public_key_name" {
  value = aws_key_pair.generated.key_name
}
