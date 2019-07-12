resource "aws_ecs_task_definition" "flask" {
    family                = "flask-task"
    container_definitions = <<DEFINITION
[
  {
    "name": "shariq-flask",
    "image": "853219876644.dkr.ecr.us-east-2.amazonaws.com/shariqflaskapp",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "memory": 128,
    "cpu": 10
  }
]
DEFINITION
}