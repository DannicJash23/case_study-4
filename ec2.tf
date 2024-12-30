resource "aws_instance" "ec2_a" {
  ami           = "ami-09b0a86a2c84101e1"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups = [aws_security_group.web_sg.id]
  key_name = "casestudy4"

  user_data = <<-EOF
              #!/bin/bash
              # Update the system
              apt-get update -y && apt-get upgrade -y

              # Install Docker
              apt-get install -y \
                ca-certificates \
                curl \
                gnupg \
                lsb-release

              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

              apt-get update -y
              apt-get install -y docker-ce docker-ce-cli containerd.io

              # Start and enable Docker
              systemctl start docker
              systemctl enable docker

              # Add 'ubuntu' user to the 'docker' group to run Docker without sudo
              usermod -aG docker ubuntu

              # Update and upgrade packages
              sudo apt update && sudo apt upgrade -y

              # Install s3fs for mounting the S3 bucket
              sudo apt-get install -y s3fs

              # Create a credentials file for s3fs with the Access and Secret keys (only if IAM role is not used)
              echo "${var.s3_access_key}:${var.s3_secret_key}" > $${HOME}/.passwd-s3fs
              sudo chmod 600 $${HOME}/.passwd-s3fs

              # Create the mount point directory if it doesn't exist
              sudo mkdir -p /home/ubuntu/mnt/s3bucket

              # Mount the S3 bucket
              echo "${aws_s3_bucket.shared_storage.bucket} /home/ubuntu/mnt/s3bucket fuse.s3fs _netdev,passwd_file=$${HOME}/.passwd-s3fs,url=https://s3.ap-south-1.amazonaws.com,use_path_request_style,allow_other 0 0" | sudo tee -a /etc/fstab

              # Mount all filesystems in fstab
              sudo mount -a
              EOF

  tags = {
    Name = "EC2-Instance-A"
  }
}

resource "aws_instance" "ec2_b" {
  ami           = "ami-09b0a86a2c84101e1"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups = [aws_security_group.web_sg.id]
  key_name = "casestudy4"

  user_data = <<-EOF
              #!/bin/bash
              # Update the system
              apt-get update -y && apt-get upgrade -y

              # Install Docker
              apt-get install -y \
                ca-certificates \
                curl \
                gnupg \
                lsb-release

              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

              apt-get update -y
              apt-get install -y docker-ce docker-ce-cli containerd.io

              # Start and enable Docker
              systemctl start docker
              systemctl enable docker

              # Add 'ubuntu' user to the 'docker' group to run Docker without sudo
              usermod -aG docker ubuntu

              # Update and upgrade packages
              sudo apt update && sudo apt upgrade -y

              # Install s3fs for mounting the S3 bucket
              sudo apt-get install -y s3fs

              # Create a credentials file for s3fs with the Access and Secret keys (only if IAM role is not used)
              echo "${var.s3_access_key}:${var.s3_secret_key}" > $${HOME}/.passwd-s3fs
              sudo chmod 600 $${HOME}/.passwd-s3fs

              # Create the mount point directory if it doesn't exist
              sudo mkdir -p /home/ubuntu/mnt/s3bucket

              # Mount the S3 bucket
              echo "${aws_s3_bucket.shared_storage.bucket} /home/ubuntu/mnt/s3bucket fuse.s3fs _netdev,passwd_file=$${HOME}/.passwd-s3fs,url=https://s3.ap-south-1.amazonaws.com,use_path_request_style,allow_other 0 0" | sudo tee -a /etc/fstab

              # Mount all filesystems in fstab
              sudo mount -a
              EOF

  tags = {
    Name = "EC2-Instance-B"
  }
}

resource "aws_instance" "ec2_c" {
  ami           = "ami-09b0a86a2c84101e1"  
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet_c.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups = [aws_security_group.web_sg.id]
  key_name = "casestudy4"

  user_data = <<-EOF
              #!/bin/bash
              # Update the system
              apt-get update -y && apt-get upgrade -y

              # Install Docker
              apt-get install -y \
                ca-certificates \
                curl \
                gnupg \
                lsb-release

              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

              apt-get update -y
              apt-get install -y docker-ce docker-ce-cli containerd.io

              # Start and enable Docker
              systemctl start docker
              systemctl enable docker

              # Add 'ubuntu' user to the 'docker' group to run Docker without sudo
              usermod -aG docker ubuntu

              # Update and upgrade packages
              sudo apt update && sudo apt upgrade -y

              # Install s3fs for mounting the S3 bucket
              sudo apt-get install -y s3fs

              # Create a credentials file for s3fs with the Access and Secret keys (only if IAM role is not used)
              echo "${var.s3_access_key}:${var.s3_secret_key}" > $${HOME}/.passwd-s3fs
              sudo chmod 600 $${HOME}/.passwd-s3fs

              # Create the mount point directory if it doesn't exist
              sudo mkdir -p /home/ubuntu/mnt/s3bucket

              # Mount the S3 bucket
              echo "${aws_s3_bucket.shared_storage.bucket} /home/ubuntu/mnt/s3bucket fuse.s3fs _netdev,passwd_file=$${HOME}/.passwd-s3fs,url=https://s3.ap-south-1.amazonaws.com,use_path_request_style,allow_other 0 0" | sudo tee -a /etc/fstab

              # Mount all filesystems in fstab
              sudo mount -a
              EOF

  tags = {
    Name = "EC2-Instance-C"
  }
}
