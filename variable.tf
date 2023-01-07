variable "subscription_id" {

    description =  "azure subsription"

    default = "XXXXX-XXXX-XXXX-XXXX-XXXXXXX"

}


variable "client_id" {

    description = "Azure Client ID"

    default = "xxxxxx-xxxx-xxxx-xxxxxx-xxxxxxxxxxx"

}

variable "client_secret" {

   description = "Azure client secret"

   default = "xxxxxx-xxxx-xxx-xxxx-xxxxxxxxxx"

}


variable "tenant_id" {

    description = "Azure Tenant ID "

    default = "xxxxxx-xxxx-xxx-xxxx-xxxxxxxxx"

}

variable "resource_group_location"  {
    default        = "eastus"
    description    = "location of nginx server resource group"
}

variable "resource_group_name_prefix"
    default       = "nginx_server_rg"
    description   = "prefix of the resource group name" 
}    