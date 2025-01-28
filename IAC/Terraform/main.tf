
  resource "google_container_cluster" "gke_cluster_tf" {
  name     = "gke-cluster-tf-02"
  deletion_protection = false
  remove_default_node_pool = true
  initial_node_count = var.initial_node_count
  project = var.project
  location   = var.node_pool_locations[0] # Primary location
}

resource "google_container_node_pool" "gke_node_pool" {
  name       = "additional-node-pool"
  cluster    = google_container_cluster.gke_cluster_tf.name
  location   = var.node_pool_locations[0] # Primary location
  node_count = var.node_pool_count
  project = var.project

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

}