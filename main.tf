# main.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS-Provider konfigurieren
provider "aws" {
  region = "eu-central-1" # Sie können die Region entsprechend Ihren Anforderungen anpassen
  profile = "Student-**************" # BITTE DEIN AWS PROFILE EINTRAGEN
}

# S3-Bucket für die Lambda-Funktion erstellen
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "learn-terraform-functions-formally-cheaply-frank-mullet" # Eindeutiger Bucket-Name

  # "acl" und "versioning" sind als veraltet markiert
  # acl    = "private"
  # versioning {
  #   enabled = true
  # }

  # Anstatt "acl" und "versioning" können Sie die "force_destroy" Einstellung verwenden
  force_destroy = true
}

# ... Weitere Konfiguration für Lambda und API Gateway hier ...
# Datenquelle für das Funktionsarchiv erstellen
data "archive_file" "lambda_hello_world" {
  type        = "zip"
  source_dir  = "${path.module}/hello-world"
  output_path = "${path.module}/hello-world.zip"
}

# S3-Objekt für das Funktionsarchiv erstellen
resource "aws_s3_object" "lambda_hello_world" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello-world.zip"
  source = data.archive_file.lambda_hello_world.output_path

  etag = filemd5(data.archive_file.lambda_hello_world.output_path)
}


# ... Weitere Konfiguration für Lambda und API Gateway hier ...

# Lambda-Funktion erstellen
resource "aws_lambda_function" "hello_world" {
  function_name = "HelloWorld"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_hello_world.key

  runtime = "nodejs12.x"
  handler = "hello.handler"

  source_code_hash = data.archive_file.lambda_hello_world.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

# CloudWatch Log-Gruppe erstellen
resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"
  retention_in_days = 30
}

# IAM-Rolle für Lambda erstellen
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# IAM-Rollenrichtlinie anhängen
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
