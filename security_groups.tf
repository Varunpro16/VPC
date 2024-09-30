
resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "lb-sg"
  
  # Allow inbound HTTP traffic from anywhere
  ingress {
    from_port   = 80     # HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg"
  }
}


resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "ec2-sg"
  
  # Allow traffic from the Load Balancer security group
  ingress {
    from_port         = 5000    # Your app's port
    to_port           = 5000
    protocol          = "tcp"
    security_groups   = [aws_security_group.lb_sg.id]  # Only allow traffic from LB SG
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}


# Create Security Group for Private Instances
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "private-sg"
  
  # Only allow private instances to communicate with the public subnet
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["10.0.1.0/24"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}

