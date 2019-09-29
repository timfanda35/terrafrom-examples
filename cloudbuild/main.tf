terraform { 
  backend "gcs" { 
    //bucket = "YOUR_BUCKET_NAME", this example use your project ID. see cloudbuild.yaml
    prefix = "terraform/state" 
  }
}

variable "PROJECT_ID" { 
  type = string
}

provider "google" { 
  //credentials = NOT NEEDED, use Cloud Build service account permissions 
  project = var.PROJECT_ID 
  region = "us-central1"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}