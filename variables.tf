variable "cert_creation_date" {
  type        = string
  description = "Certificate Creation date (as per profile uploaded from BIGIQ) - YYYYMMDD"
}

variable "create_mg" {
  type        = bool
  description = "Set True to create MG LTM configuration"
  default     = true
}

variable "create_mm" {
  type        = bool
  description = "Set True to create MG LTM configuration"
  default     = false
}

variable "create_gtm" {
  type        = bool
  description = "Set True to create GTM configuration"
  default     = false
}

variable "environment" {
  type        = string
  description = "Environment (dev, uat, sit, nft, perf, production)"
  validation {
    condition = contains(
    ["dev", "uat", "sit", "nft", "perf", "prod"], var.environment)
    error_message = "Environment must be 'dev', 'uat', 'sit', 'nft', 'perf' or 'prod'."
  }
}

variable "hostname" {
  type        = string
  description = "Hostname for the service URL"
}

variable "monitor_send_string" {
  type        = string
  description = "Base Monitor Send String (eg: GET /healthcheck/health.txt)"
  default     = "/ServiceManagement/SwitchControl.txt"
}

variable "monitor_receive_string" {
  type        = string
  description = "Monitor Receive String"
  default     = "heartbeat=1"
}

variable "monitor_type" {
  type        = string
  description = "Type of Monitor"
  default     = "https"
}

variable "output_path" {
  type        = string
  description = "Path to output file (defaults to outputs folder)"
  default     = "./outputs"
}

variable "parent_profile_prefix" {
  type        = string
  description = "Name Prefix for the parent profiles"
  default     = "profile_rbs_parent"
}

variable "partition_desc" {
  type        = string
  description = "Partition Description (CI name and Oracle Code)"
}

variable "partition_name" {
  type        = string
  description = "Name of the F5 Partition"
  default     = "Common"
}

variable "site" {
  type        = map(object({
      vip_ip = string,
      pool_port = string,
      pool_members = map(map(string))
  }))
  description = "Map of site-specific details"
}

variable "vip_port" {
  type        = string
  description = "Service port for the F5 Virtual Server"
  default     = "443"
}
