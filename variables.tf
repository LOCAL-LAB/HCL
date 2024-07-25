#variable "aws_acces_key" {}

#variable "aws_secret_key" {}

variable "aws_region" {
    type = string
    description = "Region AWS"
    default = "eu-central-1"

  
}

variable "instance_type" {
    type = list(string)
    description = "Lista typów instancji EC2"
    default = ["t2.micro"] 
}

variable "ami_id" {
    description = "ID obrazu ami"
    type = string
    default = "ami-0e872aee57663ae2d"
}
