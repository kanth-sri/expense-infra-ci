variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}


variable "zone_name" {
    default = "srikanthadepu.online"
}

variable "zone_id" {
    default = "Z02632882WFOI23E22TF"
}
