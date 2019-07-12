resource "aws_ecs_task_definition" "nginx" {
    family                = "nginx-task"
    container_definitions = <<DEFINITION
[
  {
    "name": "shariq-nginx",
    "image": "853219876644.dkr.ecr.us-east-2.amazonaws.com/shariqnginxapp",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "memory": 128,
    "cpu": 10
  }
]
DEFINITION
}