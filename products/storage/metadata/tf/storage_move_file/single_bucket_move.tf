variable "bucket_name" {
    type        = string
}
variable "file_name" {
    type        = string
}

resource "google_storage_bucket" "default" {
  name          = var.bucket_name
  location      = "EU"
  force_destroy = true

  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "default" {
  name   = var.file_name
  content = " this is the content! "
  bucket = google_storage_bucket.default.name
}


# export TF_VAR_bucket_name = some-random-name
# export TF_VAR_file_name = another-random-name
# terraform apply
# or
# terraform apply -var="bucket_name=unique-bucket-3135sd" -var="file_name=test-file"