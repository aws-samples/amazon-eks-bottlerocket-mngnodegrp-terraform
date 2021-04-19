############################ Launch template variables
variable "bottlerocket" {
  type        = bool
  default     = true
  description = "Use Bottlerocket OS, rather than Amazon Linux"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels that will be added to the kubernetes node."
}

variable "taints" {
  type        = map(string)
  default     = { }
  description = "taints that will be added to the kubernetes node"
}


variable "bottlerocket_admin_source" {
  type        = string
  default     = ""
  description = "The URI of the control container"
}

variable "instance_size" {
  type        = string
  #default     = "large"
  default     = "m5.large"
  description = "The size of instances in this node group"
}

variable "key_name" {
  type    = string
  default = ""
}

variable "root_volume_size" {
  type        = number
  default     = 40
  description = "Volume size for the root partition"
}
