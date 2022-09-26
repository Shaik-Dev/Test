terraform {
  required_version = "~> 0.14" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  } 
}  
# Provider Block
provider "aws" {
  region = "us-east-1"
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
resource "aws_cloudwatch_metric_alarm" "Low_Disk_Space_For_root_drive" {
  alarm_name                = "Low_Disk_Space_For_root_drive"
  comparison_operator       = "GreaterThanThreshold"
  #what is this evaluation period
  evaluation_periods        = "2"
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"

  dimensions = {
      InstanceId    = "i-0338263369656a24a"
      ImageId       = "ami-090fa75af13c156b4"
      InstanceType  = "t2.small"
      path          = "/"
      device        = "xvda1"
      fstype        = "xfs"
  }

  period                    = "300"
  statistic                = "Average"
  threshold                 = "85" 
  alarm_description         = "Disk usage for / is high"
  insufficient_data_actions = []
  actions_enabled           = true
  alarm_actions             = ["arn:aws:sns:us-east-1:838312633746:new1"]
  ok_actions                = ["arn:aws:sns:us-east-1:838312633746:new1"]
}
