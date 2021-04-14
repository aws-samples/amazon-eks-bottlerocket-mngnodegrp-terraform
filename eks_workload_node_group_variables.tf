
variable "worker_desired_size" {
  type        = number
  default     = 3
  description = "The minimum number of instances that will be launched by this group, if not a multiple of the number of AZs in the group, may be rounded up"
}
variable "worker_max_size" {
  type        = number
  default     = 5
  description = "The minimum number of instances that will be launched by this group, if not a multiple of the number of AZs in the group, may be rounded up"
}

variable "worker_min_size" {
  type        = number
  default     = 3
  description = "The minimum number of instances that will be launched by this group, if not a multiple of the number of AZs in the group, may be rounded up"
}

