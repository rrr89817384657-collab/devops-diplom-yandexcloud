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
  cloud_id                 = "b1gnfsvvugjvrkpvs34a"
  folder_id                = "b1gdtdsm3gtnu5k218d7"
  zone                     = "ru-central1-a"
}
