resource "random_password" "this" {
  count   = var.master_password == null ? 1 : 0
  length  = 16
  special = false
}

resource "random_id" "snap" {
  byte_length = 4
}

resource "aws_rds_cluster_instance" "this" {
  count                        = var.number_of_instance
  identifier                   = "${local.uid}-${count.index}"
  cluster_identifier           = aws_rds_cluster.this.id
  instance_class               = var.instance_class
  publicly_accessible          = var.publicly_accessible
  performance_insights_enabled = var.performance_insights_enabled
  engine                       = var.engine
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  monitoring_interval          = var.monitoring_interval
  apply_immediately            = var.apply_immediately
}

resource "aws_rds_cluster" "this" {
  cluster_identifier              = "${local.uid}-cluster"
  engine_version                  = var.engine_version
  availability_zones              = var.availability_zones
  final_snapshot_identifier       = "${local.uid}-snap-${random_id.snap.hex}"
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password == null ? random_password.this[0].result : var.master_password
  apply_immediately               = var.apply_immediately
  backtrack_window                = var.backtrack_window
  backup_retention_period         = var.backup_retention_period
  port                            = var.port
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  skip_final_snapshot             = var.skip_final_snapshot
  storage_encrypted               = var.storage_encrypted
  db_subnet_group_name            = aws_db_subnet_group.this.name
  engine                          = var.engine
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.export_log ? ["postgresql"] : null
  // reuse or creae new if not provide
  vpc_security_group_ids = local.base_infra.db_sg_ids
}

resource "aws_db_subnet_group" "this" {
  name       = "${local.uid}_db_subnet_group"
  subnet_ids = local.base_infra.app_subnet_ids
}
