terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.9.0, < 6.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.64.0, < 7.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.10"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.1.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

resource "google_compute_address" "unused_static_ip" {
  name = "expensive-unused-static-ip"
}

resource "google_compute_disk" "unattached_large_disk" {
  name = "large-unattached-premium-disk"
  type = "pd-ssd"
  size = 500
  zone = "us-central1-a"
}

# VPC Network
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.0"

  project_id   = var.gcp_project_id
  network_name = "gke-vpc"

  subnets = [
    {
      subnet_name   = "gke-subnet"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.gcp_region
    }
  ]
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 30.0"

  project_id                 = var.gcp_project_id
  name                       = "gke-cluster"
  region                     = var.gcp_region
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = "gke-pods-range"
  ip_range_services          = "gke-services-range"
  remove_default_node_pool   = false
  release_channel            = "RAPID"

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  node_pools = [
    {
      name               = "primary-node-pool"
      machine_type       = "n2-standard-16"
      min_count          = 3
      max_count          = 10
      disk_type          = "pd-ssd"
      disk_size_gb       = 250
      initial_node_count = 3
    },
    {
      name               = "spot-pool-for-batch"
      machine_type       = "e2-standard-8"
      spot               = true
      min_count          = 0
      max_count          = 20
      initial_node_count = 0
    },
  ]
}