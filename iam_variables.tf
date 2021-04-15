variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cluster_autoscaler" {
  type        = bool
  default     = true
  description = "Should this group be managed by the cluster autoscaler"
}

