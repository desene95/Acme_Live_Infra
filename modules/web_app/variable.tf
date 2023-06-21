

variable "location" {
  type        = string
  default     = "West Europe"
  description = "default resources location"
}

variable "web_plan_name"{
    type = string
    description =   "Web plan name"
    default     =   "Acme_Web_Plan"
}

variable "web_app_name"{
    type = string
    description = "Web app name"
}

variable "resource_group_name" {
   type        = list(string)
   description = "resource group name"
 }