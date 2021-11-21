variable "create_mg" {
    type = bool
    description = "Set True to create MG LTM configuration"
    default = false
}

variable "create_mm" {
    type = bool
    description = "Set True to create MG LTM configuration"
    default = false
}

variable "create_gtm" {
    type = bool
    description = "Set True to create GTM configuration"
    default = false
}

variable "partition_name" {
    type = string
    description = "Name of the F5 Partition"
    default = "Common"
}

variable "partition_desc" {
    type = string
    description = "Partition Description (CI name and Oracle Code)"
}

variable "monitor_send_string" {
    type = string
    description = "Base Monitor Send String (eg: GET /healthcheck/health.txt)"
}

variable "monitor_receive_string" {
    type = string
    description = "Monitor Receive String"
}

variable "monitor_type" {
    type = string
    description = "Type of Monitor"
    default = "https"
}

variable "site" {
    type = string
    description = "Site code (MM or MG)"
}

variable "environment" {
    type = string
    description = "Environment (dev, uat, sit, nft, perf, prod)"
}

variable "output_path" {
    type = string
    description = "Path to output file (defaults to outputs folder)"
}

variable "hostname" {
    type = string
    description = "Hostname for the service URL"
}

variable "vip_ip" {
    type = string
    description = "Virtual Server IP address"
}

variable "vip_port" {
    type = string
    description = "Service port for the F5 Virtual Server"
}

variable "pool_port" {
    type = string
    description = "Service port for the F5 pool"
}

variable "parent_profile_prefix" {
    type = string
    description = "Name Prefix for the parent profiles"
}

variable "cert_creation_date" {
    type = string
    description = "Certificate Creation date (as per profile uploaded from BIGIQ) - YYYYMMDD"
}

variable "pool_members" {
    type = map(map(string))
    description = "List of pool members and their details"
}
