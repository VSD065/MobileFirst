variable "gcp_credentials_file" {
  description = "Path to GCP credentials JSON file"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for the GKE cluster"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "The zone for the GKE cluster"
  type        = string
  default     = "asia-south1-a"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "node_machine_type" {
  description = "The machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}
