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


variable "instance_size"  {

    type = string 

    description = "Azure instance size"

    default = "Standard_F2" 

}


variable "Location"  {

    type = string 

    description = "Environment" 

    default = "West US"

}


variable "environment" {

   type = string

   description - "Environment"

    default = "dev"

}