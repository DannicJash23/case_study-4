resource "aws_security_group" "web_sg" {
  name        = "web_security_group"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.main_vpc.id

  # Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from anywhere
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH traffic from anywhere (modify for more restricted access)
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPS traffic from anywhere
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"         # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic to anywhere
  }

  tags = {
    Name = "WebSecurityGroup"
  }
}
