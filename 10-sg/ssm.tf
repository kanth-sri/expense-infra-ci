resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.project}/${var.environment}/mysql_sg_id"
  type  = "String"
  value = module.mysql_sg.sg_id
}
resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion_sg.sg_id
}
resource "aws_ssm_parameter" "controle_plane_sg_id" {
  name  = "/${var.project}/${var.environment}/controle_plane_sg_id"
  type  = "String"
  value = module.controle_plane_sg.sg_id
}
resource "aws_ssm_parameter" "node_sg_id" {
  name  = "/${var.project}/${var.environment}/node_sg_id"
  type  = "String"
  value = module.node_sg.sg_id
}
resource "aws_ssm_parameter" "ingress_sg_id" {
  name  = "/${var.project}/${var.environment}/ingress_sg_id"
  type  = "String"
  value = module.ingress_sg.sg_id
}