variable "ibmcloud_api_key" {
  description = "Enter the API key to access IBM Cloud."
}

provider "ibm" {
  ibmcloud_api_key = "${var.ibmcloud_api_key}"
}
