resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.dns_prefix

  private_cluster_enabled = var.private_cluster_enabled

  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.vm_size
    mode       = "System"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "Standard"
  }

  api_server_authorized_ip_ranges = ["<IP_RANGE_1>", "<IP_RANGE_2>"]
}
