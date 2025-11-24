variable "vmws_user" {
  type        = string
  default     = "admin"
  description = "Username for VMware Workstation API REST"
}

variable "vmws_password" {
  type        = string
  default     = "StoPara5%"
  description = "Password for VMware Workstation API REST"
}

variable "vmws_url" {
  type        = string
  default     = "http://172.19.224.1:8697/api"
  description = "URL for VMware Workstation API REST"
}

variable "vmws_reource_frontend_sourceid" {
  type        = string
  default     = "URN4S1O5UPRBJ5J36F1G1KTQIH8U61N0"
  description = "The ID of the VM to clone (string)."
}

variable "vmws_reource_frontend_denomination" {
  type        = string
  default     = "NewInstance3"
  description = "The name of the VM"
}

variable "vmws_reource_frontend_description" {
  type        = string
  default     = "This is a new VM instance"
  description = "The description of the VM"
}

variable "vmws_reource_frontend_path" {
  type        = string
  # full path to the .vmx file to create (use forward slashes for Windows paths)
  default     = "C:/Users/gspanos/CloneFromWin100.vmx"
  description = "The path for the VM"
}

variable "vmws_reource_frontend_processors" {
  type        = number
  default     = 1
  description = "The number of processors for the VM"
}

variable "vmws_reource_frontend_memory" {
  type        = number
  default     = 512
  description = "The memory size (MB) for the VM"
}