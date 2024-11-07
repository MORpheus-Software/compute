output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "kubernetes_endpoint" {
  description = "The endpoint of the Kubernetes API server"
  value       = google_container_cluster.primary.endpoint
}
