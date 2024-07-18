provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           ="ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  key_name = "new"
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "HelloWorld"
  }
  
    connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/aditya/new")  # Update with the correct path to your private key
    host        = self.public_ip
    timeout = "4m"
  }

  provisioner "file" {
    source      = "/home/aditya/script.sh"
    destination = "/home/ubuntu/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/script.sh",
      "/home/ubuntu/script.sh"
    ]
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]

   ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self = false
     to_port = 22
   }
   ]
}


# resource "aws_key_pair" "deployer" {
#   key_name   = "key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzxU3LY0Km7h0J7plgKLBGVgPoXaCQFsMgNociJYSdJ5p2AQj/FWTVgU46CN0AKttWiGtgepC1f6lMceK5Ynxfiahc72rKBFxEjjybdoHxb3vInuslgQVS0ywP59KpIKhST98iXH0D4S36rqOTkdu7JXg9b78cgwBUBScfbcBFfo1nbbOQAwbE3rQOnEtApMghy+x2buFdriZFase3q6NOQgUvz8h8HeyGawAiO/EtinnFmF+VfYENSP157k2FpiBlJIuCFcEYObptdImWFbxbYyFJ10cSL9WrEYbSJmQDTvIFs0fIK8zez0ge4DhqrfhB3htITlu+FYbCxTSOEj2H aditya@aditya-1-2"
# }
