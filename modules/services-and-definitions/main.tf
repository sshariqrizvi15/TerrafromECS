data "aws_ecs_task_definition" "flask" {
  task_definition = "${aws_ecs_task_definition.flask.family}"
}

data "template_file" "flask_task_definition" {
  template = "${file("${"${path.module}/templates/flask-task-definition.json"}")}"
}

resource "aws_ecs_task_definition" "flask" {
    family                = "flask-task"
    container_definitions = "${data.template_file.flask_task_definition.rendered}"
}

data "aws_ecs_task_definition" "nginx" {
  task_definition = "${aws_ecs_task_definition.nginx.family}"
}

data "template_file" "nginx_task_definition" {
  template = "${file("${"${path.module}/templates/nginx-task-definition.json"}")}"
}

resource "aws_ecs_task_definition" "nginx" {
    family                = "nginx-task"
    container_definitions = "${data.template_file.nginx_task_definition.rendered}"
}

resource "aws_ecs_service" "test-flask-service" {
  	name            = "test-flask-service"
  	iam_role        = "${var.ecs-service-role}"
  	cluster         = "${var.ecs_cluster}"
  	task_definition = "${aws_ecs_task_definition.flask.family}:${max("${aws_ecs_task_definition.flask.revision}", "${data.aws_ecs_task_definition.flask.revision}")}"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${var.flask-target-group}"
    	container_port    = 5000
    	container_name    = "shariq-flask"
	}
}

resource "aws_ecs_service" "test-nginx-service" {
  	name            = "test-nginx-service"
  	iam_role        = "${var.ecs-service-role}"
  	cluster         = "${var.ecs_cluster}"
  	task_definition = "${aws_ecs_task_definition.nginx.family}:${max("${aws_ecs_task_definition.nginx.revision}", "${data.aws_ecs_task_definition.nginx.revision}")}"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${var.ecs-target-group}"
    	container_port    = 80
    	container_name    = "shariq-nginx"
	}
}