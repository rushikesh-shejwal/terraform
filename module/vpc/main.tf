resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "Rushi_VPC"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block_private
  availability_zone = var.avail_zone_private

  tags = {
    Name = "Private_subnet"
  }
}


resource "aws_subnet" "public_subent" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block_public
  availability_zone = var.avail_zone_public


  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Project_IGW"
  }
}

resource "aws_route_table" "public_rtbl" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = var.my-ip
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "rtbl_association" {
  subnet_id      = aws_subnet.public_subent.id
  route_table_id = aws_route_table.public_rtbl.id
}


resource "aws_eip" "my_eip" {}


resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subent.id
  depends_on = [ aws_eip.my_eip ]
  tags = {
    Name = "Project NAT"
  }
}

resource "aws_route_table" "private_rtbl" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = var.my-ip
    nat_gateway_id = aws_nat_gateway.my_nat.id
  }
}

resource "aws_route_table_association" "private_rtbl_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rtbl.id
}
