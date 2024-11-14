# GKE Cluster definition
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = 1
  remove_default_node_pool = true
  deletion_protection = false
}

# Node Pool with Autoscaling
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  node_locations = ["us-west1-a", "us-west1-b"]

  node_config {
    machine_type    = var.node_machine_type
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    guest_accelerator {
      type  = "nvidia-tesla-t4"
      count = 1
      
      gpu_driver_installation_config {
        gpu_driver_version = "DEFAULT"
      }
    }
    

    # Optional: Specify a boot disk size to ensure enough space for GPU workloads
    disk_size_gb = 100
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

# Helm Repository Definition
resource "helm_release" "morphus-lumerin-deployment" {
  name       = "morphus-lumerin-nodes"
  chart      = "morpheus-lumerin-node"   # Name of the chart as defined in the repository index
  version    = "1.0.1"
  repository = "https://aether-rise.github.io/charts"  # GitHub Pages URL for the Helm repository

  # Pass the dynamic values
  set {
    name  = "proxyRouter.env.WALLET_PRIVATE_KEY"
    value = var.wallet_private_key
  }

  set {
    name  = "proxyRouter.env.ETH_NODE_ADDRESS"
    value = var.eth_node_address
  }

  set {
    name  = "proxyRouter.env.ETH_NODE_CHAIN_ID"
    value = tostring(var.eth_node_chain_id)
  }

  set {
    name  = "proxyRouter.env.DIAMOND_CONTRACT_ADDRESS"
    value = var.diamond_contract_address
  }

  set {
    name  = "proxyRouter.env.MOR_TOKEN_ADDRESS"
    value = var.mor_token_address
  }

  reset_values = true
  depends_on   = [google_container_cluster.primary, google_container_node_pool.primary_nodes]
}

