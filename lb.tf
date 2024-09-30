# Define the Application Load Balancer
resource "aws_lb" "application_lb" {
  name               = "my-application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id,aws_subnet.public_subnet_b.id]  # Add your public subnets here

  enable_deletion_protection = false

  tags = {
    Name = "my-application-lb"
  }
}


# Define the Target Group
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 5000  # Target instances should listen on this port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "my-target-group"
  }
}

# Define the Listener for the Load Balancer
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80  # Port on which the ALB listens for incoming traffic
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn  # Forward traffic to the target group
  }
}

# Attach an EC2 instance to the Target Group
resource "aws_lb_target_group_attachment" "example" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.web_server.id  # This EC2 instance will receive traffic from the target group
}

