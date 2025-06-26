output "gke_cluster_name" {
  description = "The name of the GKE cluster."
  value       = module.gke.name
}

output "gke_cluster_region" {
  description = "The region of the GKE cluster."
  value       = module.gke.region
}

output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = module.gke.endpoint
}

output "vpc_network_name" {
  description = "The name of the VPC network."
  value       = module.vpc.network_name
}