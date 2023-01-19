terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

## PROVIDERS
provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "idempotency-state-table" {
  name           = "idempotency_state"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "key"
  range_key      = "user_id"

  attribute {
    name = "key"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

#   attribute {
#     name = "response"
#     type = "S"
#   }

#   attribute {
#     name = "status"
#     type = "N"
#   }

#   attribute {
#     name = "method"
#     type = "S"
#   }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Name        = "idempotency-example"
  }
}

