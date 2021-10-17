resource "aws_iam_role_policy_attachment" "task_execute" {
  role       = aws_iam_role.task_execute.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "task_execute" {
  name   = "${local.uid}-task-exe-policy"
  role   = aws_iam_role.task_execute.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "logs:CreateLogGroup",
          "ssm:GetParameters",
          "ssm:GetParameter"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "task_execute" {
  name = "${local.uid}-task-exe-role"
  path = "/"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}
