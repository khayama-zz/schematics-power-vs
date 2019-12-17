variable "ibmcloud_api_key" {
  description = "Enter the API key to access IBM Cloud classic infrastructure. For more information for how to create an API key and retrieve it, see [Managing classic infrastructure API keys](https://cloud.ibm.com/docs/iam?topic=iam-classic_keys)."
}

provider "ibm" {
  ibmcloud_api_key = "${var.ibmcloud_api_key}"
}
