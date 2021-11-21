locals {
    is_production = var.environment == "prod" ? "true" : "false"
}


data "template_file" "tmsh" {
    template = file("${path.module}/template/tmsh_config.tpl")
    vars = {
        site = var.site
        partition_name = var.partition_name
        partition_desc = var.partition_desc

        monitor_type = var.monitor_type
        monitor_receive_string = var.monitor_receive_string
        monitor_send_string = var.monitor_send_string

        service_url = "${var.hostname}.${local.is_production ? "web" : "webdev" }.banksvcs.net"
        vip_ip   = var.vip_ip
        vip_port = var.vip_port
        pool_port = var.pool_port

        pool_members = file("${path.module}/temp/rendered_pool_members.txt")

        parent_profile_prefix = var.parent_profile_prefix
        cert_creation_date = var.cert_creation_date
    }
    
    depends_on = [
        null_resource.combine_rendered_pool_members,
    ]
}

resource "local_file" "tmsh_config" {
    content = data.template_file.tmsh.rendered
    filename = "${var.output_path}/ltm_tmsh_config_${var.site}.txt"
}


######### These resources render the Pool Members config

data "template_file" "pool" {
    for_each = var.pool_members
    template = file("${path.module}/template/pool_member.tpl")
    vars = {
        member_name = each.key
        member_port = lookup(each.value, "port")
        member_ip   = lookup(each.value, "ip")
    }
}

resource "local_file" "pool_config" {
    for_each = var.pool_members
    content = data.template_file.pool[each.key].rendered
    filename = "${path.module}/temp/pool_${each.key}_${var.site}.txt"
}

resource "null_resource" "combine_rendered_pool_members" {
    provisioner "local-exec" {
        working_dir = "${path.module}/temp"
        command = "cat pool* > rendered_pool_members.txt"
  }
}

resource "null_resource" "clean_pool_members_rendered_file" {
    provisioner "local-exec" {
        working_dir = "${path.module}/temp"
        command = "rm pool*.txt && > rendered_pool_members.txt"
  }
    depends_on = [
        data.template_file.tmsh,
    ]
}