#terraform {
#    required_version = ">= 1.9.2"
#    required_providers {
#     aws = { 
#       source = "hashicorp/aws"
#       version = "5.58.0" 
#    }
#  }
#}

#     provider "aws" {
#     # Configuration options
#     region = var.aws_region
#     }
#
#    #resource "aws_vpc" "siec-terraform" {
#    #    cidr_block = "10.0.0.0/16"
#    #}

#resource "aws_instance" "example" {
#  for_each = toset(var.instance_type)
#  ami = var.ami_id
#  instance_type = each.value
#  tags = {
#    Name = "Instancja-${each.key}"
#  }
#}

