resource "aws_ecs_service" "test-flask-service" {
  	name            = "test-flask-service"
  	iam_role        = "${var.ecs-service-role}"
  	cluster         = "${var.ecs_cluster}"
  	task_definition = "flask-task:9"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${var.flask-target-group}"
    	container_port    = 5000
    	container_name    = "shariq-flask"
	}
}