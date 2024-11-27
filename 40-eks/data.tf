data "aws_ssm_parameter" "ssm_controle_plane_sg_id" {
  name = "/${var.project}/${var.environment}/controle_plane_sg_id"
}
data "aws_ssm_parameter" "ssm_node_sg_id" {
  name = "/${var.project}/${var.environment}/node_sg_id"
}
data "aws_ssm_parameter" "ssm_private_subnet_ids" {
  name = "/${var.project}/${var.environment}/private_subnet_ids"
}
data "aws_ssm_parameter" "ssm_vpc" {
  name = "/${var.project}/${var.environment}/vpc_id"
}


data "aws_ami" "ami_id"{
    most_recent = true
    owners = [ "973714476881" ]

    filter {
      name = "name"
      values = ["RHEL-9-DevOps-Practice"]
    }
    filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}