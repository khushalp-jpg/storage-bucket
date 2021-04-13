// Regional storage bucket
resource "google_storage_bucket" "jerry2" {
  project       = "steadfast-task-294706"  
  name  = "myjerry"
  location = "europe-west2"
}

// Service Account
resource "google_service_account" "storage_reader_writer" {
  account_id = "storagebucketreader"
  project       = "steadfast-task-294706"
  display_name = "storagereader"
  description =  "this account user for storage reader of jerry2"
}

// Service Account Key
resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.storage_reader_writer.name
}

// IAM Bindings
resource "google_storage_bucket_iam_binding" "bucket_creator" {
  bucket = "${google_storage_bucket.jerry2.name}"
  role = "roles/storage.objectCreator"
  members = [
    join(":", ["serviceAccount", google_service_account.storage_reader_writer.email])
  ]
}

resource "google_storage_bucket_iam_binding" "bucket_reader" {
  bucket = "${google_storage_bucket.jerry2.name}"
  role = "roles/storage.objectViewer"
  members = [
    join(":", ["serviceAccount", google_service_account.storage_reader_writer.email])
  ]
}