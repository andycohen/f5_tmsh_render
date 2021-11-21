module "ltm_tmsh_config" {
    for_each               = var.site
    source                 = "./modules/render_tmsh"
    environment            = var.environment
    partition_name         = var.partition_name
    partition_desc         = var.partition_desc
    monitor_type           = var.monitor_type
    monitor_send_string    = var.monitor_send_string
    monitor_receive_string = var.monitor_receive_string
    hostname               = var.hostname
    parent_profile_prefix  = var.parent_profile_prefix
    cert_creation_date     = var.cert_creation_date
    output_path            = var.output_path
    vip_port              = var.vip_port

    site                  = each.key
    vip_ip                = lookup(each.value, "vip_ip")
    pool_port             = lookup(each.value, "pool_port")
    pool_members          = lookup(each.value, "pool_members")
}
