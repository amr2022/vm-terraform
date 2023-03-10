output  "resource_group_name"  {
    value    =  azurem_resource_group.nginx_server_rg.name
}

output "public_ip_address"  {
    value    = azurerm_linux_virtual_machine.nginx_server_vm.nginx_server_PublicIP
}

output "tls_private_key"  {
    value    = tls_private_key.t1_ssh.private_key_pem
    sensitive  = true 
}