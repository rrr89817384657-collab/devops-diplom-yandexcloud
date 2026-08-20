# Используем образ Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# SSH ключ (создай, если нет)
resource "yandex_compute_instance" "k8s-master" {
  name        = "k8s-master"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
  hostname    = "k8s-master"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "k8s-worker-1" {
  name        = "k8s-worker-1"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"
  hostname    = "k8s-worker-1"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "k8s-worker-2" {
  name        = "k8s-worker-2"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"
  hostname    = "k8s-worker-2"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-d.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

output "master_ip" {
  value = yandex_compute_instance.k8s-master.network_interface[0].nat_ip_address
}

output "worker_1_ip" {
  value = yandex_compute_instance.k8s-worker-1.network_interface[0].nat_ip_address
}

output "worker_2_ip" {
  value = yandex_compute_instance.k8s-worker-2.network_interface[0].nat_ip_address
}

output "all_ips" {
  value = [
    yandex_compute_instance.k8s-master.network_interface[0].nat_ip_address,
    yandex_compute_instance.k8s-worker-1.network_interface[0].nat_ip_address,
    yandex_compute_instance.k8s-worker-2.network_interface[0].nat_ip_address
  ]
}
