# Terraform with proxmox

## Create VM clone

1. Download the ISO using the GUI (tested on https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img)
2. Create the VM via CLI

```
qm create 6000 --memory 2048 --core 2 --name ubuntu-noble-cloud-template2 --net0 virtio,bridge=vmbr0
cd /var/lib/vz/template/iso/
qm importdisk 6000 noble-server-cloudimg-amd64.img DATA
qm set 6000 --scsihw virtio-scsi-pci --scsi0 DATA:vm-6000-disk-0
qm set 6000 --ide2 DATA:cloudinit
qm set 6000 --boot c --bootdisk scsi0
qm set 6000 --serial0 socket --vga serial0
qm set 6000 --agent 1
qm set 6000 --ciuser ubuntu
qm set 6000 --cipassword azerazer
qm set 6000 --ciupgrade 1
qm set 6000 --sshkeys /root/ricky.pub
qm set 6000 --ipconfig0 ip=dhcp
qm set 6000 --net0 model=virtio,tag=150,bridge=vmbr0
```

3. Expand the VM disk size to a suitable size (suggested 10 GB)
4. Create the Cloud-Init template
5. Deploy new VMs by cloning the template (full clone)

## Run terraform

```
terraform init
terraform apply -auto-approve
```
