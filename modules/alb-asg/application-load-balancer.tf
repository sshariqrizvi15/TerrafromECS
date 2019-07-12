resource "aws_alb" "ecs-load-balancer" {
    name                = "ecs-load-balancer"
    security_groups     = ["${var.test_public_sg}"]
    subnets             = ["${var.test_public_sn_01}", "${var.test_public_sn_02}"]

    tags {
      Name = "ecs-load-balancer"
    }
}

resource "aws_alb_target_group" "ecs-target-group" {
    name                = "ecs-target-group"
    port                = "80"
    protocol            = "HTTP"
    vpc_id              = "${var.test_vpc}"

    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }

    tags {
      Name = "ecs-target-group"
    }
}

resource "aws_alb_target_group" "flask-target-group" {
    name                = "flask-target-group"
    port                = "5000"
    protocol            = "HTTP"
    vpc_id              = "${var.test_vpc}"

    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }

    tags {
      Name = "flask-target-group"
    }
}

resource "aws_alb_listener" "alb-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
        type             = "forward"
    }
}

resource "aws_alb_listener" "alb-flask-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "5000"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.flask-target-group.arn}"
        type             = "forward"
    }
}