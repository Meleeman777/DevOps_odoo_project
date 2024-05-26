terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.keyfile
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone

}

data "yandex_compute_image" "my_image" {
  family = var.family
}
