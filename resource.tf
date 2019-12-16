variable "datacenter" {
  type        = "string"
  description = "Ex) tok02, tok04, tok05, ..."
  default = "tok04"
}

variable "os_reference_code" {
  type        = "string"
  description = "Ex) CENTOS_LATEST_64, CENTOS_7_64, CENTOS_6_64, REDHAT_LATEST, UBUNTU_LATEST, WIN_LATEST_64, WIN_2016-STD_64, ..."
  default = "CENTOS_7_64"
}

variable "flavor_key_name" {
  type        = "string"
  description = "Ex) C1_1X1X100, B1_1X4X100, B1_2X4X100, B1_2X8X100, U1_1X2X100, U1_2X4X100, U1_4X8X100, ..."
  default = "B1_1X2X100"
}

resource "ibm_compute_vm_instance" "khayama-test" {
    hostname = "khayama-test"
    domain = "ibmcloud.com"
    os_reference_code = "${var.os_reference_code}"
    datacenter = "${var.datacenter}"
    network_speed = 100
    hourly_billing = true
    transient = true
    local_disk = false
    private_network_only = false
    flavor_key_name = "${var.flavor_key_name}"
    public_security_group_ids = [1287613]
    tags = ["user:khayama"]
    notes = "khayama's Resource created by Schematics"
}
