resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D4s_v3"
  node_count            = 3
  mode                  = "User"
}

resource "azurerm_kubernetes_cluster_node_pool" "spot" {
  name                  = "spotpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D4s_v3"
  node_count            = 2
  mode                  = "User"
  spot_max_price        = -1  # Use -1 to indicate the current On-Demand price
}
