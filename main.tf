terraform {
  required_version = ">= 1.9.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}

resource "aws_security_group" "apache2_server_sg" {
    name = "apache2_server_sg"
    description = "Allow apache2-container traffic"
    vpc_id = "vpc-061e4db19102014ef"
    
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 4444
        to_port = 4444
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "apache2_server_sg"
    }
}

resource "aws_instance" "apache2_server" {
    count = 3
    ami = var.ami_id
    instance_type = "t2.micro"
    security_groups = [aws_security_group.apache2_server_sg.name]
    key_name = "ALX"

    provisioner "remote-exec" {
        inline = [ 
            "sudo apt update -y",
            "sudo apt install docker.io -y",
            "sudo systemctl enable --now docker",
            "sudo usermod -aG docker root",
            "sudo docker pull ubuntu/apache2:2.4-22.04_beta",
            "sudo docker pull selenium/standalone-chrome",
            "sudo docker run -d --name apache2-container -e TZ=UTC -p 8080:80 -v /var/www/html/:/var/www/html ubuntu/apache2:2.4-22.04_beta",
            "sudo docker run -d --name selenium-container -e TZ=UTC -p 4444:4444 -v /dev/shm:/dev/shm selenium/standalone-chrome",
         ]

    connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = file("ALX.pem")
        host     = self.public_ip
  }
      
    }

    tags = {
      Name = "apache2_dev_${count.index + 1}"
    }
  
}


