provider "aws" {}
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 10"
  }
}
