resource "local_file" "hosts_file" {
  filename = "${path.module}/../../../ansible/hosts.ini"
  content = templatefile("${path.module}/hosts.ini.tftpl", {
    concrete_csm_public_ip = var.concrete_csm_public_ip
  })
}