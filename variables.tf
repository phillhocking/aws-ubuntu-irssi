variable "access_key" {}
variable "secret_key" {}
variable "management_cidr_block" {}
variable "key_name" {
  default = "terraform"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "irc_username" {
  default = "erasmus"
}

variable "gh_username" {
  default = "phillhocking"
}

variable "irssi_gist" {
  default = "af404e560fb60255c5db7f9ecfe844ec"
}
