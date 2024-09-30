# Create Public Subnet in us-west-1b
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1b"  # Public Subnet 1
  tags = {
    Name = "public-subnet-a"
  }
}

# Create Public Subnet in us-west-1c
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1c"  # Public Subnet 2
  tags = {
    Name = "public-subnet-b"
  }
}

# Create Private Subnet in us-west-1b
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-1b"  # Private Subnet 1
  tags = {
    Name = "private-subnet-a"
  }
}

# Create Private Subnet in us-west-1c
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-west-1c"  # Private Subnet 2
  tags = {
    Name = "private-subnet-b"
  }
}

