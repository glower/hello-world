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

# GKE Cluster
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
  remove_default_node_pool   = true
  initial_node_count         = 1
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = var.gke_machine_type
      min_count          = var.min_cluster_size
      max_count          = var.max_cluster_size
      initial_node_count = var.desired_cluster_size
    },
  ]
}