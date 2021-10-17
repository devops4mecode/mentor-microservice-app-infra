resource "aws_ssm_parameter" "password" {
  description = "Password for Aurora Posgres ${local.uid}"
  name        = "/${var.env_id}/${var.app_id}/postgres/password"
  type        = "SecureString"
  value       = var.master_password == null ? random_password.this[0].result : var.master_password
}

resource "aws_ssm_parameter" "username" {
  description = "Username for Aurora Posgres ${local.uid}"
  name        = "/${var.env_id}/${var.app_id}/postgres/username"
  type        = "SecureString"
  value       = var.master_username
}

resource "aws_ssm_parameter" "url" {
  description = "Url for Aurora Posgres ${local.uid}"
  name        = "/${var.env_id}/${var.app_id}/postgres/url"
  type        = "String"
  value       = aws_rds_cluster.this.endpoint
}

//App SSM constring
resource "aws_ssm_parameter" "user-db-conn" {
  description = "User DB connection string ${local.uid}"
  name        = "/${var.env_id}/${var.app_id}/postgres/user-db"
  type        = "SecureString"
  value       = "postgresql://${var.master_username}:${aws_ssm_parameter.password.value}@${aws_rds_cluster.this.endpoint}:5432/user-db?schema=public"
}

resource "aws_ssm_parameter" "prod-db-conn" {
  description = "Product DB connection string ${local.uid}"
  name        = "/${var.env_id}/${var.app_id}/postgres/product-db"
  type        = "SecureString"
  value       = "postgresql://${var.master_username}:${aws_ssm_parameter.password.value}@${aws_rds_cluster.this.endpoint}:5432/product-db?schema=public"
}
