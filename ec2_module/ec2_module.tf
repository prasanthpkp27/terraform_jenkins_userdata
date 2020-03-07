variable "amiId" {
	default = "ami-05695932c5299858a"
}

variable "sg_id" {}
variable "ec2_name" {}
resource "aws_instance" "terraform-ec2" {
	ami = var.amiId
	instance_type = "t2.micro"
	key_name = "devops"
	vpc_security_group_ids = ["${var.sg_id}"]
	user_data = file("assets/userdata.txt")
  tags = {
    Name = var.ec2_name
    }
}