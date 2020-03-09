data "aws_vpc" "default" {
   default = true
}

resource "aws_security_group" "common_sg" {
  name = "${var.instance_name}_SG"
  vpc_id = data.aws_vpc.default.id
  description = "${var.instance_name} Security Group"

  tags = {
        Name = "${var.instance_name}_SG"
    }
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.common_sg.id
}

resource "aws_security_group_rule" "ingress" {
  count             = length(compact(var.allowed_ports))
  type              = "ingress"
  from_port         = var.allowed_ports[count.index]
  to_port           = var.allowed_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = var.whitelisted_ip
  security_group_id = aws_security_group.common_sg.id
}