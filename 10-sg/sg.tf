module "mysql_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "mysql"
  common_tags = var.common_tags
}
module "bastion_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "bastion"
  common_tags = var.common_tags
}
module "ingress_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "ingress"
  common_tags = var.common_tags
}
module "controle_plane_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "k8s_control"
  common_tags = var.common_tags
}
module "node_sg" {
  source = "git::https://github.com/kanth-sri/aws-sg-module.git"
  vpc_id = local.vpc_id
  project = var.project
  environment = var.environment
  sg_name = "k8s-node"
  common_tags = var.common_tags
}

resource "aws_security_group_rule" "ingress_sg_public" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.ingress_sg.sg_id
}
resource "aws_security_group_rule" "bastion_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.bastion_sg.sg_id
}
resource "aws_security_group_rule" "bastion_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.bastion_sg.sg_id
}

resource "aws_security_group_rule" "node-ingress" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  source_security_group_id = module.ingress_sg.sg_id
  security_group_id = module.node_sg.sg_id
}

resource "aws_security_group_rule" "node-bastion-22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.node_sg.sg_id
}
resource "aws_security_group_rule" "node-bastion-443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.node_sg.sg_id
}
resource "aws_security_group_rule" "controle_plane_node" {
  type              = "ingress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  source_security_group_id = module.node_sg.sg_id
  security_group_id = module.controle_plane_sg.sg_id
}
resource "aws_security_group_rule" "node_control" {
  type              = "ingress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  source_security_group_id = module.controle_plane_sg.sg_id
  security_group_id = module.node_sg.sg_id
}
resource "aws_security_group_rule" "node_node" {
  type              = "ingress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks = [ "10.0.0.0/16" ]
  security_group_id = module.node_sg.sg_id
}
resource "aws_security_group_rule" "controle_plane_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.controle_plane_sg.sg_id
}
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}
resource "aws_security_group_rule" "mysql_node" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.node_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}


