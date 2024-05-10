resource "tls_private_key" "key" {
  algorithm = "RSA"
}

# Pull out public key attributes from generated key (generate key)
resource "aws_key_pair" "server_key" {
  key_name   = "ec2-keypair"
  public_key = tls_private_key.key.public_key_openssh
}

# Save generated public key on local machine
resource "local_file" "setup_server_key" {
  content  = tls_private_key.key.private_key_pem
  filename = "ec2-keypair.pem"
}

#Instance
resource "aws_instance" "web_instance" {
  ami                         = "ami-06aa3f7caf3a30282"
  instance_type               = "t2.micro" # if instance is a "t2.large" it would be flagged as a violation
  availability_zone           = "us-east-1a"
  key_name                    = "ec2-keypair"
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  subnet_id                   = aws_subnet.dev_public_subnet.id
  associate_public_ip_address = true


  tags = {
    Name = "web-server"
  }
}

# SSH Connection into Postgres Instance and connect to Postgresql database
resource "null_resource" "install_apache" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.key.private_key_pem
    host        = aws_instance.web_instance.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      // Install Apache web server
      "sudo apt update -y",
      "sudo apt install apache2 -y",
      "sudo systemctl start apache2",
      "sudo bash -c 'echo your very first web server > /var/www/html/index.html'"
    ]
  }
}
