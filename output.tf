output "public_ip" {
  description = "Public IP of Public Instance "
  value       = module.instance.public_instance.public_ip
}

output "private_ip" {
  description = "Private IP of Private Instance"
  value       = module.instance.private_instance.private_ip
}