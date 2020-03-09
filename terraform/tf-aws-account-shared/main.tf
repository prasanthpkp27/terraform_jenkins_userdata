module "key" {
   source           = "../tf-aws-modules/tf-aws-ssh-key"
   keyname          = "jenkins.pem"
   publickey        = var.public_key
}

module "jenkins" {
	source   =  "../tf-aws-modules/tf-aws-compute"
	instance_count   =  1
	availability_zone = "eu-west-2a"
	instance_name =  "Jenkins"
	ami = "ami-0f02b24005e4aec36"
	instance_type = "t2.micro"
	masterkey = module.key.key_id
	voltype = "gp2"
	size = 20
	group_name = "Ops-group"
	allowed_ports = ["8080","443","80"]
	whitelisted_ip = ["0.0.0.0/0"]
	user_data = file("./userdata.txt")
}
