# Deploy FortiVM

## Create VM clone

1. Download the KVM qcow2 file
2. Transfer the file to your proxmox server through SCP or whatever you want
3. Create the VM via GUI without media, cpu host
4. Import Qcow2 file : qm importdisk <ID> fortios.qcow2 DATA
5. With GUI, edit the unsed disk created with cache writeback and discard
6. Modify boot order and set scsi1 (last disk created)
7. Deploy new VMs by cloning the template (full clone)

The first disk is for logs

## Run terraform

```
terraform init
terraform apply -auto-approve
```

## Destroy VM

```
terraform state list
terraform plan -destroy -target proxmox_vm_qemu.fortivm
terraform destroy -auto-approve
```
