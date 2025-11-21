variable "region" {
  default = "us-west-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default = "my-bucket-tf-test-repo1"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
