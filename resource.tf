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

resource "ibm_pi_volume" "pi_volume"{
  pi_volume_size       = 10
  pi_volume_name       = "khayama-volume"
  pi_volume_type       = "standard"
  pi_volume_shareable  = true
  pi_cloud_instance_id = "${data.ibm_resource_instance.resource_instance.id}"
}

resource "ibm_pi_network" "pi_network" {
  count                = 1
  pi_network_name      = "khayama-network"
  pi_network_dns       = ["9.9.9.9"]
  pi_network_cidr      = "192.168.100.0/24"
  pi_network_type      = "vlan"
  pi_cloud_instance_id = "${data.ibm_resource_instance.resource_instance.id}"
}

resource "ibm_pi_instance" "pi_instance" {
    pi_instance_name      = "khayama-test"
    pi_replicants         = "1"
    pi_key_pair_name      = "khayama-key"
    pi_proc_type          = "shared"
    pi_sys_type           = "s922"  
    pi_processors         = "0.25"
    pi_memory             = "2"
    pi_image_id           = "${var.image}>"
    pi_volume_ids         = ["${data.ibm_pi_volume.pi_volume.id}"]
    pi_network_ids        = ["${data.ibm_pi_network.pi_network.networkid}"]
    pi_migratable         = "true"
    pi_replication_policy = "none"
    pi_cloud_instance_id  = "${data.ibm_resource_instance.resource_instance.id}"
  }
