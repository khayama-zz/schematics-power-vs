variable "location" {
  type        = "string"
  description = "Ex) us-south, us-east, eu-de-1, ..."
  default = "eu-de-1"
}

variable "image" {
  type        = "string"
  description = "Ex) 7100-05-04, 7200-03-03, IBMi-72-09-002, IBMi-73-06-001, IBMi-74-00-001, ..."
  default = "IBMi-74-00-001"
}

data "ibm_resource_group" "group" {
  name = "khayama-rg"
}

resource "ibm_resource_instance" "resource_instance" {
  name              = "khayama-power"
  service           = "power-iaas"
  plan              = "power-virtual-server-group"
  location          = "${var.location}"
  resource_group_id = "${data.ibm_resource_group.group.id}"
  tags              = ["user:khayama"]
}

resource "ibm_pi_instance" "test-instance" {
    pi_instance_name      = "test-vm"
    pi_replicants         = "1"
    pi_key_pair_name      = "khayama-key"
    pi_proc_type          = "shared"
    pi_sys_type           = "s922"  
    pi_processors         = "0.25"
    pi_memory             = "2"
    pi_image_id           = "${var.image}>"
    pi_volume_ids         = []
    pi_network_ids        = ["<id of the VM's network IDs>"]
    pi_migratable         = "true"
    pi_replication_policy = "none"
    pi_cloud_instance_id  = "${data.ibm_resource_instance.resource_instance.id}"
  }
