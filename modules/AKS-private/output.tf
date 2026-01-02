output "aks_id" {
  value = azurerm_kubernetes_cluster.private-aks.id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.private-aks.kube_config_raw
  sensitive = true
}

output "private_fqdn" {
  value = azurerm_kubernetes_cluster.private-aks.private_fqdn
}
