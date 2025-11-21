terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}


# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name


  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          data.aws_s3_bucket.my_bucket.arn,
          "${data.aws_s3_bucket.my_bucket.arn}/*"
        ]
      }
    ]
  })
}
# Optional: enable versioning
# resource "aws_s3_bucket_versioning" "versioning" {
#   bucket = aws_s3_bucket.my_bucket.id

#   versioning_configuration {
#     status = "Disabled"
#   }
# }

# Optional: enable server-side encryption
# resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
#   bucket = aws_s3_bucket.my_bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }
