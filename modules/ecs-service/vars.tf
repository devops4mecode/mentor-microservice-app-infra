variable "name" {
  type        = string
  description = "The name of service"
}

variable "env_id" {
  type        = string
  description = "The environment flag"
}

variable "app_id" {
  type        = string
  description = "The id to identify the application"
}

variable "cpu" {
  type        = number
  description = "The number of cpu units used by the task, default: 128"
  default     = 256
}

# Valid fargate memory and cpu setting https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
variable "memory" {
  type        = number
  description = "The amount (in MiB) of memory used by the task, default: 128"
  default     = 512
}

variable "image" {
  type        = string
  description = "The docker image for the application, leave it blank, it will read from file IMAGE"
  default     = null
}

variable "containerPort" {
  type        = number
  description = "The port for application to listen to"
  default     = null
}

variable "lbPort" {
  type        = number
  description = "The port for load balancer to listen to"
  default     = 80
}

variable "environment" {
  type        = map(string)
  description = "Environment to be set for application"
  default     = null
}

variable "secret" {
  type        = map(string)
  description = "Secret to be set for application"
  default     = null
}

variable "desired_count" {
  type        = number
  description = "Min replication to run for application"
  default     = 1
}

# If your VPC no NAT routing for public traffic, you need to enable public ip
variable "assign_public_ip" {
  type        = bool
  description = "Enable public ip for the task"
  default     = true
}

variable "alb_paths" {
  type        = list(string)
  description = "Alb path to route to this service"
  default     = null
}
