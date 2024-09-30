# EC2 Instance definition
resource "aws_instance" "web_server" {
  ami                    = "ami-0d53d72369335a9d6"  # Example AMI (UBUNTU)
  instance_type = "t3.micro"
  
  subnet_id              = aws_subnet.public_subnet_a.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]  # Associate the security group
  
  key_name = "optisol"  # SSH key pair for logging in

  tags = {
    Name = "WebServer"
  }
}
