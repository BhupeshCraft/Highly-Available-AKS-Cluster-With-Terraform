resource "azurerm_kubernetes_cluster" "aks" {
  ...

  default_node_pool {
    ...
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 10
  }
}
