variable "project" {
  description = "The ID of the project"
  type        = string
}

variable "region" {
  description = "The region for the GKE cluster"
  type        = string
  default     = "us-east4"
}

variable "location" {
  description = "The location of the GKE cluster"
  type        = string
  default     = "us-east4-a"
}
variable "node_pool_locations" {
  description = "List of zones where the node pool will be created"
  type        = list(string)
  default     = ["us-east4-a", "us-east4-b"]
}

variable "machine_type" {
  description = "The machine type for the nodes"
  type        = string
  default     = "g1-small"
}

variable "disk_size_gb" {
  description = "The size of the disk in GB"
  type        = number
  default     = 10
}

variable "initial_node_count" {
  description = "The initial number of nodes in the GKE cluster"
  type        = number
  default     = 1
}

variable "node_pool_location" {
  description = "The location for the node pool"
  type        = string
  default     = "us-east4-c"
}

variable "node_pool_count" {
  description = "The initial number of nodes in the node pool"
  type        = number
  default     = 1
}
