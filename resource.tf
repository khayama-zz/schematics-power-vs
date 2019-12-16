variable "location" {
  type        = "string"
  description = "Ex) us-south, us-east, eu-de-1, ..."
  default = "eu-de-1"
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
