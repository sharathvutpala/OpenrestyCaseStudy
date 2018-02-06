#user data template.

data "template_file" "web_server" {
  template = "${file("${path.module}/templates/userdata.tpl")}"
}

#=================================================================================
#Creates a security group with ingress http 80 port and egress open to all
resource "aws_security_group" "http" {
  name        = "http"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#=====================================================================================
#actual websever creation with userdata taken from template.
#by default it uses default vpc. I assuemed the instance creation is done in completely new environment

resource "aws_instance" "web-server" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  vpc_security_group_ids = ["${aws_security_group.http.id}",
    "${aws_security_group.ssh.id}",
  ]

  user_data = "${data.template_file.web_server.rendered}"
  key_name  = "${var.ssh_key_id}"

  tags {
    Name = "web-server"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.root_filesystem_size}"
    delete_on_termination = true
  }

  # always use the ephemeral space ... for swap
  ephemeral_block_device {
    device_name  = "/dev/sdd"
    virtual_name = "ephemeral0"
  }
}
