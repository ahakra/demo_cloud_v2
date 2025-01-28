terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.18.0"


    }

  }
  backend "gcs" {
    bucket  = "demo_cloud_v2_bucket"
    prefix  = "terraform/state"


  }
}

provider "google" {
  project     = var.project
  zone        = var.zones[0]

}