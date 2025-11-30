resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "ssh_private_key" {
  filename = "${path.module}/../../../ansible/.ssh/ssh_private_key"
  content  = tls_private_key.ssh_key.private_key_pem
}

resource "aws_key_pair" "generated" {
  key_name   = "concrete-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}
