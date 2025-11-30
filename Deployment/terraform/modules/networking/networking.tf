// vpc
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC AS"
  }
}

// internet gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id     = aws_vpc.main_vpc.id
  depends_on = [aws_vpc.main_vpc]

  tags = {
    Name = "igw AS"
  }
}

// public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id # Associe le sous-réseau au VPC
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 0)
  availability_zone = var.vpc_availability_zone

  tags = {
    Name = "public subnet AS"
  }
}


// route table for the public subnet
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  depends_on = [aws_internet_gateway.main_igw]
  tags = {
    Name = "Public Route AS"
  }
}



// route table associations
resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id      = aws_subnet.public_subnet.id
}