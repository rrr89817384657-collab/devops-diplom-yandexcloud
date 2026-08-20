terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "diploma-tfstate"
    region = "ru-central1"
    key    = "prod/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  service_account_key_file = "/home/oman/key.json"
  cloud_id                 = var.yandex_cloud_id
  folder_id                = var.yandex_folder_id
  zone                     = var.yandex_default_zone
}

resource "yandex_container_registry" "diploma-registry" {
  name       = "diploma-registry"
  folder_id  = var.yandex_folder_id
  labels = {
    project = "diploma"
    managed_by = "terraform"
  }
}

output "registry_id" {
  description = "ID of the created Container Registry"
  value       = yandex_container_registry.diploma-registry.id
}

output "registry_name" {
  description = "Name of the created Container Registry"
  value       = yandex_container_registry.diploma-registry.name
}
