resource "aws_s3_bucket" "shared_bkt_001" {
  bucket = "shared_bkt_001"
  
  tags = {
    Name = "shared_bkt_001"
  }
}
