terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    organization = "KTB21-Load-Testing"

    workspaces {
      name = "Cloud-Terraform"
    }
  }
}

variable "slack_webhook_url" {
  description = "Slack 알림을 위한 웹훅 URL"
  type        = string
  default     = ""  # 필요에 따라 기본값 설정
}
