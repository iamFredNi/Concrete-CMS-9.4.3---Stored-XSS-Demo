resource "aws_instance" "concrete_csm_instance" {
  ami           = "ami-049442a6cf8319180"
  instance_type = "t3.medium"
  key_name      = var.ssh_public_key_name

  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.app_sg_id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = false
  }

  tags = {
    Name = "Concrete CSM Instance"
  }
}


