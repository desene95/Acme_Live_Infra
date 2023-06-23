variable "resource_group_name" {
   type        = list(string)
   description = "resource group name"
 }

 variable "location" {
  type        = string
  default     = "West Europe"
  description = "default resources location"
}

variable "vnet_name" {
  type = string
}

variable "addr_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "addr_pref" {
    type = list(string)
  
}

variable "pe_name"{}
variable "pe_conn"{}
variable "private_link_enabled_resource_id" {
  
}

variable "private_link_enabled_resource_id_1" {
  
}

variable "subresource_names" {
    type = list(string)
  
}

variable "subresource_names_1" {
    type = list(string)
  
}

variable "pe_name_1" {
  
}

variable "pe_conn_1" {
  
}