variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
  default     = "us-west1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "mln-cluster"
}

variable "node_machine_type" {
  description = "The machine type for the GKE nodes"
  type        = string
  default     = "n1-standard-4"
}

# Define variables for wallet private key and eth node address
variable "wallet_private_key" {
  description = "Wallet private key for signing transactions"
  type        = string
}

variable "eth_node_address" {
  description = "ETH Node Address for connecting to Ethereum network"
  type        = string
}

variable "eth_node_chain_id" {
  description = "Chain ID for the Ethereum testnet"
  type        = number
}

variable "diamond_contract_address" {
  description = "Diamond contract address"
  type        = string
}

variable "mor_token_address" {
  description = "MOR token address"
  type        = string
}

variable "gpu_type" {
  description = "GPU Type that the nodes should use"
  type        = string
  default     = "nvidia-tesla-t4"
}


