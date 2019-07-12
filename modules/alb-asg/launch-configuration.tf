resource "aws_launch_configuration" "ecs-launch-configuration" {
    name                        = "ecs-launch-configuration"
    image_id                    = "ami-0eba5aab4550a443a"
    instance_type               = "t2.micro"
    iam_instance_profile        = "${var.ecs-instance-profile}"

    lifecycle {
      create_before_destroy = true
    }

    security_groups             = ["${var.test_public_sg}"]
    associate_public_ip_address = "true"
    key_name                    = "ShariqKeyPair"
    user_data                   = <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
                                  EOF
}