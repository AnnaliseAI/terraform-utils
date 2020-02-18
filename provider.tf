provider "aws" {}

# force download of null resource provider
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}

#  force download of archive provider
data "archive_file" "zip" {
  type        = "zip"
  output_path = "my.zip"
}
