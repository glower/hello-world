
variable "gcp_project_id" {
  description = "The GCP project ID to deploy to."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy to."
  type        = string
  default     = "us-central1"
}

variable "gke_machine_type" {
  description = "The machine type for the GKE nodes."
  type        = string
  default     = "e2-medium"
}

variable "min_cluster_size" {
  description = "The minimum number of nodes in the GKE cluster."
  type        = number
  default     = 1
}

variable "max_cluster_size" {
  description = "The maximum number of nodes in the GKE cluster."
  type        = number
  default     = 3
}

variable "desired_cluster_size" {
  description = "The desired number of nodes in the GKE cluster."
  type        = number
  default     = 1
}
