provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# Create a custom VPC network
resource "google_compute_network" "vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks  = false
}

# Create a subnet for GKE
resource "google_compute_subnetwork" "private_subnet" {
  name                     = "private-subnet"
  region                   = var.region
  network                  = google_compute_network.vpc.self_link
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true
}

# Create a service account for GKE
resource "google_service_account" "gke_sa" {
  account_id   = "gke-service-account" # A valid account ID (use a string of lowercase letters and hyphens)
  display_name = "GKE Service Account"
}

# IAM roles for GKE
resource "google_project_iam_member" "gke_service_account" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

# Create the GKE cluster
resource "google_container_cluster" "gke_cluster" {
  name     = "devops-task-cluster"
  location = var.zone

  initial_node_count     = 1
  remove_default_node_pool = true

  # Network configuration for the GKE cluster
  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.private_subnet.self_link
}

# Create a node pool
resource "google_container_node_pool" "primary_node_pool" {
  cluster = google_container_cluster.gke_cluster.name
  location = var.zone
  name     = "primary-node-pool"
  initial_node_count = 1

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }

}

# Create firewall rules for HTTP and SSH access
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
   lifecycle {
    ignore_changes = [name]  # Ignore changes to the 'name' attribute
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
   lifecycle {
    ignore_changes = [name]  # Ignore changes to the 'name' attribute
  }
}
# Define health check for the backend service
resource "google_compute_http_health_check" "nginx_health_check" {
  name = "nginx-health-check"
  port = 80
}


