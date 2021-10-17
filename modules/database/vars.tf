variable "app_id" {
  type = string
}
variable "env_id" {
  type = string
}

variable "port" {
  type        = number
  description = "The port on which the DB accepts connections, default 5432"
  default     = 5432
}

variable "preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: 01:00-04:00"
  default     = "01:00-04:00"
}

variable "engine_version" {
  type        = string
  description = "The database engine version"
  default     = "13.3"
}

variable "engine" {
  type        = string
  description = "The name of the database engine to be used for this DB cluster. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql"
  default     = "aurora-postgresql"
}

variable "preferred_maintenance_window" {
  type        = string
  description = "The weekly time range during which system maintenance can occur, in (UTC) default sun:04:00-sun:04:30"
  default     = "sun:04:00-sun:04:30"
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}

variable "monitoring_interval" {
  type        = number
  description = " The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = " Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default true."
  default     = true
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB cluster is encrypted. The default is false"
  default     = false
}

variable "number_of_instance" {
  type        = number
  description = "Number of instance for cluster, default 1"
  default     = 1
}

variable "performance_insights_enabled" {
  type        = string
  description = "Specifies whether Performance Insights is enabled or not. Default false"
  default     = false
}

variable "export_log" {
  type        = bool
  description = "Should the log export to cloudwatch, Defautl false"
  default     = false
}

variable "publicly_accessible" {
  type        = bool
  description = "Bool to control if instance is publicly accessible. Default false. See the documentation on Creating DB Instances for more details on controlling this property."
  default     = false
}

variable "instance_class" {
  type        = string
  description = "The instance class to use. For details on CPU and memory, see Scaling Aurora DB Instances. Aurora uses db.* instance classes/types. Please see AWS Documentation for currently available instance classes and complete details."
  default     = "db.t3.medium"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security groups to associate with the Cluster, skip this will create new SG automatically"
  default     = null
}

variable "skip_final_snapshot" {
  type        = string
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final_snapshot_identifier. Default is false."
  default     = false
}

variable "database_name" {
  type        = string
  description = "Name for an automatically created database on cluster creation. There are different naming restrictions per database engine"
  default     = null
}

variable "master_password" {
  type        = string
  description = "Master password for the cluster, if not provide will auto generate and store in parameter store"
  default     = null
}

variable "backtrack_window" {
  type        = number
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours)"
  default     = 0
}

variable "backup_retention_period" {
  type        = string
  description = "The days to retain backups for. Default 1"
  default     = 1
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is false"
  default     = true
}

variable "master_username" {
  type        = string
  description = "The master username for the database,default postgres"
  default     = "postgres"
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created. RDS automatically assigns 3 AZs if less than 3 AZs are configured, which will show as a difference requiring resource recreation next Terraform apply. It is recommended to specify 3 AZs or use the lifecycle configuration block ignore_changes argument if necessary."
  default     = null
}

