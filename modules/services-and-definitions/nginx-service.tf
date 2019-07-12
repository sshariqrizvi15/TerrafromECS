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