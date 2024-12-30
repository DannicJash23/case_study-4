resource "aws_s3_bucket" "shared_storage" {
  bucket = "my-shared-s3-bucket004"
  
  tags = {
    Name = "my-shared-s3-bucket004"
  }
}
