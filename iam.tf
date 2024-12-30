# IAM Role for EC2
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for S3 Access
resource "aws_iam_policy" "s3_access_policy" {
  name        = "S3AccessPolicy"
  description = "Policy to allow access to S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListObject"]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.shared_storage.arn}/*"
      }
    ]
  })
}

# Attach the S3 Access Policy to the Role
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  policy_arn = aws_iam_policy.s3_access_policy.arn
  role       = aws_iam_role.ec2_s3_role.name
}

# Create an IAM Instance Profile for the Role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-s3-access-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}
