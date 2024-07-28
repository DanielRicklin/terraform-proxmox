resource "proxmox_vm_qemu" "ubuntu_noble" {
  # count = 2
  # name  = "ubuntu-noble-${count.index + 1}"
  name        = var.vm_name
  target_node = "pve"
  clone       = "ubuntu-noble-cloud-template"
  full_clone  = true

  ciuser     = var.vm_user
  cipassword = var.vm_password

  agent = 1

  cores   = var.vm_cores
  sockets = 1
  cpu     = "host"
  memory  = var.vm_ram

  os_type = "cloud-init"
  scsihw  = "virtio-scsi-pci"

  network {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = var.vm_vlan_tag
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
          size    = var.vm_disk_size
        }
      }
    }
  }

  boot = "order=scsi0"

  #   ipconfig0  = "ip=10.1.192.${26 + count.index + 1}/29,gw=10.1.192.25"
  ipconfig0 = var.vm_ipconfig
  # nameserver = "9.9.9.9"

  sshkeys = <<EOF
        ${var.ssh_key}
        EOF

}
