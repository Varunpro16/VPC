# Create NAT Gateway for Private Subnet
resource "aws_eip" "nat_eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags = {
    Name = "main-nat-gw"
  }
}
