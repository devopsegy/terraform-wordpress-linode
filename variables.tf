variable "token" {
  description = "Linode API Personal Access Token"
}

variable "image" {
  description = "Image to use for Linode instance"
  default = "linode/ubuntu16.04lts"
}

variable "label" {
  description = "The Linode's label is for display purposes only."
  default = "default-linode"
}

variable "region" {
  description = "The region where your Linode will be located."
  default = "us-east"
}

variable "type" {
  description = "Your Linode's plan type."
  default = "g6-standard-1"
}

variable "stackscript_id" {
  description = "Stackscript ID"
}

variable "stackscript_data" {
  description = "Map of required StackScript UDF data."
  type = "map"
}

variable "domain" {
  description = "The domain this domain represents."
}

variable "soa_email" {
  description = "Start of Authority email address. This is required for master domains."
}

variable "a_record" {
  description = "The type of DNS record. For example, `A` records associate a domain name with an IPv4 address."
  default = "A"
}
