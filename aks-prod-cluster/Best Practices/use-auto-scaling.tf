resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D4s_v3"
  node_count            = 3
  min_count             = 1
  max_count             = 5
  enable_auto_scaling   = true
  mode                  = "User"
}
