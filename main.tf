resource "random_pet"  "nginx_server_name"   {
    prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group"  "nginx_server_rg"  {
    location = var.resource_group_location
    name = random_pet.nginx_server_rg.id
} 

resource "azurerm_virtual_network"  "nginx_server_network"
   name                    =  "Vnet1"
   address_space           = ["10.0.0.0/16"]
   location                = azurerm_resource_group.nginx_server_rg.location
   resource_group_name     = azurerm_resource_group.nginx_server_rg.name
}

resource "azurerm_public_ip"  "nginx_server_PublicIP"  {
    name                   = "nginx_subnet"
    resource_group_name    = azurerm_resource_group.nginx_server_rg.name
    virtual_network_name   = azurerm_virtual_network.nginx_server_network.name
    address-prefixes       = ["10.0.1.0/24"]
}

resource "azurerm_public_ip"  "nginx_server_rg" {
    name                   = "nginx_server_PublicIP"
    location               = azurerm_resource_group.nginx_server_rg.location
    resource_group_name    = azurem_resource_group.nginx_server_rg.name
    allocation_method      = "Dynamic"
}

resource "azurem_network_security_group"  "nginx_server_nsg" {
    name                   = "nginx_server_nsg"
    location               = azurerm_resource_group.nginx_server_rg.location
    resource_group_name    = azurem_resource_group.nginx_server_rg.name

    security_rule {
        name                             = "SSH"
        priority                         =  1001
        direction                        = "Inbound"
        access                           = "Allow"
        protocol                         = "Tcp"
        source_port_range                = "*"
        destination_port_range           = "22"
        source_address_prefix            = "*"
        distination_address_prefix       = "*"

       }
    }

resource "azurerm_network_interface" "nginx_server_nic"  {
    name                                 = "NIC1"
    location                             = "azurerm_resource_group.nginx_server_rg.location
    resource_group_name                  = azurerm_resource_group.nginx_server_rg.name

    ip_configuration  { 
        name                             = "my_nic_configuration"
        subnet_id                        = azurerm_subnet.nginx_subnet.id
        private_ip_address_allocation    = "Dynamic"
        public_ip_address_id             = azurerm_public_ip.nginx_server_PublicIP.ID
    }
}

resource "azurerm_network_interface_security_group_association" "default_security_group"  {
    network_inetrface_id                 = azurerm_network_interface.nginx_server_nic.id
    network_security_group_id            = azurem_network_security_group.default_security_group_nsg.id
}

resource "random_id"  "random_id"  {
    keepers = {
        resource_group = azurem_resource_group.nginx_server_rg.name
    }
    byte_length = 8
}

resource "azurerm_storage_account"  "ngx_storage_account"  {
    name                                 = "diag${random_id.random_id.hex}"
    location                             = azurem_resource_group.nginx_server_rg.location
    resource_group_name                  = azurem_resource_group.nginx_server_rg.name
    account_tier                         = "Standard"
    account_replication_type             = "LRS"
    }

resource " tls_private_key"  "t1_ssh"   {
    algorithm                            = "RSA"
    rsa-bits                             = 4096
}

resource  "azurerm_linux_virtual_machine"  "nginx_server_vm"  {
    name                                 = "nginx_server_vm"
    location                             = azurem_resource_group.nginx_server_rg.location
    resource_group_name                  = azurem_resource_group.nginx_server_rg.name
    network_inetrface_ids                = [azurerm_network_interface.nginx_server_nic.id]
    size                                 = "Standard_DS1_v2"

    os_disk  {
        name                             = "nginx_os"
        caching                          = "ReadWrite"
        storage_account_type             = "Premuim_LRS"
    }

source_image_reference  {
    publisher                            = "Canonical"
    offer                                = "UbuntuServer"
    sku                                  = "18.04-LTS"
    version                              = "latest"
}

computer_name                           = "nginx_server"
admin_username                          = "admin"
admin_password                          = "amr@eissa123A$#"
disable_password_authentication         = true 

admin_ssh_key  {
    username                            = "admin"
    public_key                          = tls_private_key.t1_ssh.public_key_openssh
}

boot_diagnostics  {
    storage_account_uri  = azurerm_storage_account.ngx_storage_account.primary_blob_endpoint
    }
}

}

}
