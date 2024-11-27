locals {
  
  controle_plane_sg_id = data.aws_ssm_parameter.ssm_controle_plane_sg_id.value
  node_sg_id = data.aws_ssm_parameter.ssm_node_sg_id.value
  private_subnet_ids = split(",", data.aws_ssm_parameter.ssm_private_subnet_ids.value)
  vpc_id = data.aws_ssm_parameter.ssm_vpc.value
  ami_id = data.aws_ami.ami_id.id
}