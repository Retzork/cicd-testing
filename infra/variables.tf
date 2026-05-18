variable "app_service_plan_name" {
  type    = string
  default = "asp-cicd-bridge"
}

variable "web_app_name" {
  type        = string
  description = "Must be globally unique"
  default     = "app-cicd-bridge-2026-artha"
}
