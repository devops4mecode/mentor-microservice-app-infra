variable "subnet_ids" {
  type        = list(string)
  description = "Which subnet id should lb place in"
}
variable "app_id" {
  type = string
}
variable "env_id" {
  type = string
}
