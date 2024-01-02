/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "BUCKET_NAME" {
    type        = string
}

variable "FILE_NAME" {
    type        = string
}

resource "google_storage_bucket" "default" {
  name          = var.BUCKET_NAME
  location      = "EU"
  force_destroy = true

  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "default" {
  name   = var.FILE_NAME
  content = " this is the content! "
  bucket = google_storage_bucket.default.name
}


# export TF_VAR_bucket_name = some-random-name
# export TF_VAR_file_name = another-random-name
# terraform apply
# or
# terraform apply -var="bucket_name=unique-bucket-3135sd" -var="file_name=test-file"