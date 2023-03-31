locals {
  reliability_common_tags = merge(local.aws_well_architected_common_tags, {
    benchmark = "reliability"
  })
}

benchmark "reliability_pillar" {
  title       = "Reliability Pillar"
  description = "The reliability pillar focuses on workloads performing their intended functions and how to recover quickly from failure to meet demands. Key topics include distributed system design, recovery planning, and adapting to changing requirements."
  children = [
    benchmark.reliability_pillar_1,
    benchmark.reliability_pillar_2,
    benchmark.reliability_pillar_6,
    benchmark.reliability_pillar_7,
    benchmark.reliability_pillar_8,
    benchmark.reliability_pillar_9,
    benchmark.reliability_pillar_10
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}

benchmark "reliability_pillar_1" {
  title       = "REL 1: How do you manage service quotas and constraints?"
  description = "For cloud-based workload architectures, there are service quotas (which are also referred to as service limits). These quotas exist to prevent accidentally provisioning more resources than you need and to limit request rates on API operations so as to protect services from abuse. There are also resource constraints, for example, the rate that you can push bits down a fiber-optic cable, or the amount of storage on a physical disk."
  children = [
    control.lambda_function_concurrent_execution_limit_configured,
    control.lambda_function_dead_letter_queue_configured
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}

benchmark "reliability_pillar_2" {
  title       = "REL 2: How do you plan your network topology?"
  description = "Workloads often exist in multiple environments. These include multiple cloud environments (both publicly accessible and private) and possibly your existing data center infrastructure. Plans must include network considerations such as intra- and inter-system connectivity, public IP address management, private IP address management, and domain name resolution."
  children = [
    control.ec2_instance_in_vpc,
    control.elb_application_lb_waf_enabled,
    control.elb_classic_lb_cross_zone_load_balancing_enabled,
    control.elb_network_lb_cross_zone_load_balancing_enabled,
    control.es_domain_in_vpc,
    control.lambda_function_in_vpc,
    control.redshift_cluster_enhanced_vpc_routing_enabled,
    control.vpc_endpoint_service_acceptance_required_enabled,
    control.vpc_peering_dns_resolution_check,
    control.vpc_security_group_restrict_ingress_tcp_udp_all,
    control.vpc_vpn_tunnel_up
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}

benchmark "reliability_pillar_6" {
  title       = "REL 6: How do you monitor workload resources?"
  description = "Logs and metrics are powerful tools to gain insight into the health of your workload. You can configure your workload to monitor logs and metrics and send notifications when thresholds are crossed or significant events occur. Monitoring enables your workload to recognize when low-performance thresholds are crossed or failures occur, so it can recover automatically in response."
  children = [
    control.apigateway_rest_api_stage_xray_tracing_enabled,
    control.apigateway_stage_logging_enabled,
    control.autoscaling_group_with_lb_use_health_check,
    control.cloudtrail_multi_region_trail_enabled,
    control.cloudtrail_trail_enabled,
    control.cloudtrail_trail_integrated_with_logs,
    control.cloudwatch_alarm_action_enabled,
    control.ec2_instance_detailed_monitoring_enabled,
    control.ecs_cluster_container_insights_enabled,
    control.elastic_beanstalk_enhanced_health_reporting_enabled,
    control.elb_application_classic_lb_logging_enabled,
    control.es_domain_logs_to_cloudwatch,
    control.guardduty_enabled,
    control.lambda_function_dead_letter_queue_configured,
    control.opensearch_domain_logs_to_cloudwatch,
    control.rds_db_instance_and_cluster_enhanced_monitoring_enabled,
    control.rds_db_instance_logging_enabled,
    control.redshift_cluster_enhanced_vpc_routing_enabled,
    control.s3_bucket_logging_enabled,
    control.securityhub_enabled,
    control.vpc_flow_logs_enabled,
    control.wafv2_web_acl_logging_enabled
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}

benchmark "reliability_pillar_7" {
  title       = "REL 7: How do you design your workload to adapt to changes in demand?"
  description = "A scalable workload provides elasticity to add or remove resources automatically so that they closely match the current demand at any given point in time."
  children = [
    control.autoscaling_group_with_lb_use_health_check,
    control.autoscaling_launch_config_public_ip_disabled,
    control.dynamodb_table_auto_scaling_enabled
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}

benchmark "reliability_pillar_8" {
  title       = "REL 8: How do you implement change?"
  description = "Controlled changes are necessary to deploy new functionality, and to ensure that the workloads and the operating environment are running known software and can be patched or replaced in a predictable manner. If these changes are uncontrolled, then it makes it difficult to predict the effect of these changes, or to address issues that arise because of them."
  children = [
    control.rds_db_instance_automatic_minor_version_upgrade_enabled,
    control.redshift_cluster_maintenance_settings_check,
    control.ssm_managed_instance_compliance_patch_compliant
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}

benchmark "reliability_pillar_9" {
  title       = "REL 9: How do you back up data?"
  description = "Back up data, applications, and configuration to meet your requirements for recovery time objectives (RTO) and recovery point objectives (RPO)."
  children = [
    control.backup_plan_min_retention_35_days,
    control.backup_recovery_point_encryption_enabled,
    control.backup_recovery_point_min_retention_35_days,
    control.dynamodb_table_encrypted_with_kms,
    control.dynamodb_table_in_backup_plan,
    control.dynamodb_table_point_in_time_recovery_enabled,
    control.ebs_attached_volume_encryption_enabled,
    control.ebs_volume_in_backup_plan,
    control.ec2_ebs_default_encryption_enabled,
    control.ec2_instance_ebs_optimized,
    control.ec2_instance_protected_by_backup_plan,
    control.efs_file_system_encrypted_with_cmk,
    control.efs_file_system_in_backup_plan,
    control.elasticache_redis_cluster_automatic_backup_retention_15_days,
    control.elb_application_lb_deletion_protection_enabled,
    control.fsx_file_system_protected_by_backup_plan,
    control.rds_db_cluster_aurora_protected_by_backup_plan,
    control.rds_db_instance_backup_enabled,
    control.rds_db_instance_deletion_protection_enabled,
    control.rds_db_instance_encryption_at_rest_enabled,
    control.rds_db_instance_in_backup_plan,
    control.rds_db_snapshot_encrypted_at_rest,
    control.redshift_cluster_automatic_snapshots_min_7_days,
    control.redshift_cluster_kms_enabled,
    control.s3_bucket_cross_region_replication_enabled,
    control.s3_bucket_default_encryption_enabled_kms,
    control.s3_bucket_default_encryption_enabled,
    control.s3_bucket_object_lock_enabled,
    control.s3_bucket_versioning_enabled
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}

benchmark "reliability_pillar_10" {
  title       = "REL 10: How do you use fault isolation to protect your workload?"
  description = "Fault isolated boundaries limit the effect of a failure within a workload to a limited number of components. Components outside of the boundary are unaffected by the failure. Using multiple fault isolated boundaries, you can limit the impact on your workload."
  children = [
    control.dynamodb_table_auto_scaling_enabled,
    control.elb_application_gateway_network_lb_multiple_az_configured,
    control.elb_application_lb_deletion_protection_enabled,
    control.elb_classic_lb_cross_zone_load_balancing_enabled,
    control.elb_classic_lb_multiple_az_configured,
    control.lambda_function_multiple_az_configured,
    control.opensearch_domain_data_node_fault_tolerance,
    control.rds_db_instance_deletion_protection_enabled,
    control.rds_db_instance_multiple_az_enabled,
    control.s3_bucket_object_lock_enabled,
    control.vpc_vpn_tunnel_up
  ]

  tags = merge(local.reliability_common_tags, {
    type = "Benchmark"
  })
}
