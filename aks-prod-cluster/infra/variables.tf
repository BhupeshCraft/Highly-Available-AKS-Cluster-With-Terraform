variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "aks-prod-rg"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "aks-prod-vnet"
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "aks-prod-subnet"
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "aks-prod-cluster"
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
  default     = "aks-prod-cluster"
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "The VM size for the AKS nodes"
  type        = string
  default     = "Standard_D4s_v3"
}

variable "private_cluster_enabled" {
  description = "Enable private cluster for AKS"
  type        = bool
  default     = true
}
