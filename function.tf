data "archive_file" "init" {
  type        = "zip"
  source_dir = "src"
  output_path = "./main.zip"
}

resource "google_project_iam_binding" "secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:jenkins@cosmic-descent-405605.iam.gserviceaccount.com",
  ]
}

resource "google_storage_bucket_object" "archive" {
  name   = var.object
  bucket = var.bucket
  source = var.object
}
resource "google_cloudfunctions_function" "my-function" {
  name = "secretly"
  runtime = "python37"
  region = "europe-west4"
  service_account_email = var.svc
  trigger_http          = true
  source_archive_bucket = var.bucket
  source_archive_object = var.object
  environment_variables = {
    GCP_PROJECT_ID = var.project_id
    GCP_SECRET_ID = var.secret
  }
}
