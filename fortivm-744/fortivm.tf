resource "proxmox_vm_qemu" "fortivm" {
  name        = "fortivm-1"
  target_node = "pve"
  clone       = "fortivm-template"
  full_clone  = true

  cores   = 1
  sockets = 1
  cpu     = "host"
  memory  = 2048

  os_type = "cloud-init"
  scsihw  = "virtio-scsi-pci"

  network {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = "150"
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = "101"
  }


  disks {
    scsi {
      # LOGS
      scsi0 {
        disk {
          storage = "DATA"
          size    = "5G"
        }
      }
      # OS
      scsi1 {
        disk {
          storage = "DATA"
          size    = "20G"
        }
      }
    }
  }

  boot = "order=scsi1"

  ipconfig0 = "ip=dhcp"
}
