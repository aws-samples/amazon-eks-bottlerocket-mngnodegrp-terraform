variable "legacy_security_groups" {
  type        = bool
  default     = false
  description = "Preserves existing security group setup from pre 1.15 clusters, to allow existing clusters to be upgraded without recreation"
}

variable "log_retention" {
  type    = string
  default = "30"
}

variable "aws_auth_role_map" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
  description = "A list of mappings from aws role arns to kubernetes users, and their groups"
}

#variable "oidc_root_ca_thumbprints" {
#  type        = list(string)
#  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
#  description = "Thumbprint of Root CA for EKS OpenID Connect (OIDC) identity provider, Valid until 2037 🤞"
#}

variable "aws_auth_user_map" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
  description = "A list of mappings from aws user arns to kubernetes users, and their groups"
}

#variable "aws_ebs_csi_driver" {
#  type        = bool
#  default     = true
#  description = "Should the Amazon Elastic Block Store (EBS) CSI driver be deployed"
#}

variable "fstype" {
  type        = string
  default     = "xfs"
  description = "File system type that will be formatted during volume creation, (xfs, ext2, ext3 or ext4)"
}


variable "eks_version" {
  type    = string
  default = "1.19"
}

