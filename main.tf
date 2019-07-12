provider "aws" {
    region = "us-east-2"
}


terraform {
    backend "s3" {
        bucket = "shariqterraform"
        key = "state.tfstate"
        region = "us-east-2"
    }
}

module "vpc" {
  source = "modules/vpc"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnet_1_cidr = "${var.public_subnet_1_cidr}"
  public_subnet_2_cidr = "${var.public_subnet_2_cidr}"
}

module "iam_roles" {
  source = "modules/iam-roles"
}

module "ecs" {
  source = "modules/ecs"
  ecs_cluster = "${var.ecs_cluster}"
}

module "alb_asg" {
  source = "modules/alb-asg"
  ecs_cluster = "${module.ecs.test-ecs-cluster}"
  test_vpc = "${module.vpc.test_vpc}"
  test_public_sn_01 = "${module.vpc.test_public_sn_01}"
  test_public_sn_02 = "${module.vpc.test_public_sn_02}"
  test_public_sg = "${module.vpc.test_public_sg}"
  ecs-instance-profile = "${module.iam_roles.ecs-instance-profile}"

}

module "task_definitions" {
  source = "modules/task-definitions"
}

module "services" {
  source = "modules/services"
  ecs-service-role = "${module.iam_roles.ecs-service-role}"
  ecs_cluster = "${module.ecs.test-ecs-cluster}"
  ecs-target-group = "${module.alb_asg.ecs-target-group}"
  flask-target-group = "${module.alb_asg.flask-target-group}"
}