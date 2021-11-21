output "test" {
  value = var.site
}

# output "pm_rules_map" {
#   value = [for pm in template_file.pool.rendered : map("rule_name", lb.name, "rule_id", lb.id)]
# }

# output "pm_rules_all" {
#   value = module.ltm_tmsh_config_mg.pm_rendered
# }