variable "resource_group_name" {
   type        = list(string)
   description = "resource group name"
 }

 variable "location" {
  type        = string
  default     = "West Europe"
  description = "default resources location"
}

variable "db_server"{
    type = string
    #default = "Acme-DB-Server"
    description = "DB server name"
}

variable "db_name"{
    type = string
    #default = "Acme-DB-1"
    description = "DB name"
}

variable "kv_name" {
    type = string
    description = "Key vault name"
}