variable "proxmox_api_url" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "ssh_key" {
  type      = string
  sensitive = true
}

variable "vm_name" {
  type    = string
  default = "ubuntu-noble-1"
}

variable "vm_cores" {
  type    = number
  default = 2
}

variable "vm_ram" {
  type    = number
  default = 4096
}

variable "vm_disk_size" {
  type    = string
  default = "20G"
}

variable "vm_ipconfig" {
  type    = string
  default = "ip=dhcp"
}

variable "vm_vlan_tag" {
  type    = string
  default = "150"
}

variable "vm_user" {
  type    = string
  default = "ubuntu"
}

variable "vm_password" {
  type    = string
  default = "ubuntu"
}
