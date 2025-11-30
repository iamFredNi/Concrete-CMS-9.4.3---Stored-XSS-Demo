resource "aws_network_acl" "public_subnet_acl" {
  vpc_id = aws_vpc.main_vpc.id

  # Règle de sortie pour tout le trafic (egress)
  egress {
    protocol   = "-1" # Permet tous les protocoles
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0" # Permet tout le trafic vers n'importe quelle adresse IP
    from_port  = 0
    to_port    = 0 # Permet tous les ports
  }

  # Règle d'entrée pour tout le trafic (ingress)
  ingress {
    protocol   = "-1" # Permet tous les protocoles
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0" # Permet tout le trafic en provenance de n'importe quelle adresse IP
    from_port  = 0
    to_port    = 0 # Permet tous les ports
  }

  tags = {
    Name = "ACL for Public Subnet"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Security group for EC2 instances"

  vpc_id = aws_vpc.main_vpc.id

  # App on port 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH , à restreindre après Ansible
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

resource "aws_network_acl_association" "public_acl_association" {
  subnet_id      = aws_subnet.public_subnet.id
  network_acl_id = aws_network_acl.public_subnet_acl.id
}

