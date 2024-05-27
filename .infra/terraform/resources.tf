resource "yandex_compute_instance" "final-vm" {
  name        = var.name
  platform_id = var.platform
  zone        = var.zone
  labels = {
    user_email = var.email
    task_name  = var.task_name
  }
  resources {
    cores  = 2
    memory = 3

  }

  boot_disk {
    initialize_params {
    image_id = data.yandex_compute_image.my_image.id
    size = 20
    }
  }

  network_interface {
    subnet_id = var.networkid
    nat   = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"

  }
  provisioner "remote-exec" {
    connection {
      host        = self.network_interface["0"].nat_ip_address
      user        = "ubuntu"
      type        = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      timeout     = "1m"
    }
    inline = [
      "echo check connection"
    ]
  }
}

data "aws_route53_zone" "primary" {
        name = "devops.rebrain.srwx.net"
}


resource "aws_route53_record" "final" {
        zone_id = data.aws_route53_zone.primary.zone_id
        name    = "finaltask.devops.rebrain.srwx.net"
        type    = "A"
        ttl     = "300"
        records = [yandex_compute_instance.final-vm.network_interface.0.nat_ip_address]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tftpl",
    {
        yandexnames =  [yandex_compute_instance.final-vm.name],
        yandexip =  [yandex_compute_instance.final-vm.network_interface.0.nat_ip_address]
    }
  )
  filename = "/home/rebrain/final/.infra/ansible/hosts.ini"
}


resource "terraform_data" "ansible" {
  provisioner "local-exec" {
    command = "cd /home/rebrain/final/.infra/ansible  && ansible-playbook  all.yml --private-key=/home/rebrain/.ssh/id_rsa -e @vault/vault.yml"
  }
  depends_on = [local_file.ansible_inventory]
}


