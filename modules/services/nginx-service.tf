resource "aws_ecs_service" "test-nginx-service" {
  	name            = "test-nginx-service"
  	iam_role        = "${var.ecs-service-role}"
  	cluster         = "${var.ecs_cluster}"
  	task_definition = "nginx-task:1"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${var.ecs-target-group}"
    	container_port    = 80
    	container_name    = "shariq-nginx"
	}
}