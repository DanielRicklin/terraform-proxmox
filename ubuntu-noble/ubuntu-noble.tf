variable "ssh_key" {
  type      = string
  sensitive = true
}

resource "proxmox_vm_qemu" "ubuntu_noble" {
  # count = 2
  # name  = "ubuntu-noble-${count.index + 1}"
  name        = "ubuntu-noble-1"
  target_node = "pve"
  clone       = "ubuntu-noble-cloud-template"
  full_clone  = true

  agent = 1

  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 4096

  os_type = "cloud-init"
  scsihw  = "virtio-scsi-pci"

  network {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = "150"
  }

  disks {
    ide {
      ide3 {
        cloudinit {
          storage = "DATA"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "DATA"
          size    = "20G"
        }
      }
    }
  }

  boot = "order=scsi0"

  #   ipconfig0  = "ip=10.1.192.${26 + count.index + 1}/29,gw=10.1.192.25"
  ipconfig0 = "ip=dhcp"
  # nameserver = "9.9.9.9"

  sshkeys = <<EOF
        ${var.ssh_key}
        EOF

}
