terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

# --- ΑΥΤΟ ΕΙΝΑΙ ΤΟ BLOCK ΠΟΥ ΛΕΙΠΕΙ ---
variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}
# --------------------------------------
provider "hcloud" {
  token = var.hcloud_token
}

# Εισαγωγή του SSH Key σου
resource "hcloud_ssh_key" "my_key" {
  name       = "lab-ssh-key"
  public_key = file("/home/gspanos/.ssh/id_rsa.pub") 
}

# --- Firewall: Μόνο SSH (Port 22) ---
resource "hcloud_firewall" "ssh_only" {
  name = "ssh-only-firewall"
  
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

}

# --- Server CX42 ---
resource "hcloud_server" "kube_lab" {
  name         = "minikube-lab"
  image        = "ubuntu-24.04"
  server_type  = "cx43"
  location     = "nbg1"
  ssh_keys     = [hcloud_ssh_key.my_key.id]
  firewall_ids = [hcloud_firewall.ssh_only.id]

  user_data = <<-EOT
    #!/bin/bash
    # Update & Docker Installation
    apt-get update && apt-get upgrade -y
    apt-get install -y ca-certificates curl gnupg
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io

    # Kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    # Minikube
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    install minikube-linux-amd64 /usr/local/bin/minikube

    # Εκκίνηση Minikube
    minikube start --driver=docker --force
  EOT
}

output "server_ip" {
  value = hcloud_server.kube_lab.ipv4_address
}