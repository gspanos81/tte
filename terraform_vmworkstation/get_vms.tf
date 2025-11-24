# Data source to query VMware Workstation REST API for all VMs
data "http" "get_vms" {
  url      = "${var.vmws_url}/vms"
  method   = "GET"
  
  request_headers = {
    Content-Type      = "application/json"
    Authorization     = "Basic ${base64encode("${var.vmws_user}:${var.vmws_password}")}"
  }
}

# Parse the JSON response
locals {
  vms_response = try(jsondecode(data.http.get_vms.response_body), {})
}

# Output all VMs as JSON
output "all_vms_json" {
  description = "Raw JSON response of all VMs"
  value       = local.vms_response
  sensitive   = true
}

# Output formatted VM list
output "all_vms" {
  description = "List of all VMs in VMware Workstation"
  value       = try(local.vms_response.vms, [])
  sensitive   = false
}

# Output VM IDs
output "vm_ids" {
  description = "List of all VM IDs"
  value       = try([for vm in local.vms_response.vms : vm.id], [])
}

# Output VM names
output "vm_names" {
  description = "List of all VM names"
  value       = try([for vm in local.vms_response.vms : vm.denomination], [])
}
