resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret"

  labels = {
    cost = "media"
  }

  replication {
    user_managed {
      replicas {
        location = "europe-west4"
      }
    }
  }
}


resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id

  secret_data = "secret-data"
}