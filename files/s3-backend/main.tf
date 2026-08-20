terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "/home/oman/key.json"
  cloud_id                 = "b1gnfsvvugjvrkpvs34a"
  folder_id                = "b1gdtdsm3gtnu5k218d7"
  zone                     = "ru-central1-a"
}

resource "yandex_storage_bucket" "tf-state-bucket" {
  bucket = "diploma-tfstate"
  acl    = "private"
}

output "bucket_name" {
  value = yandex_storage_bucket.tf-state-bucket.bucket
}
