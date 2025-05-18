data "archive_file" "main" {
  type        = "zip"
  output_path = "${var.src_path}/${var.name}.zip"
  source_dir  = var.src_path

  excludes = ["**/*.zip"]
}

resource "google_storage_bucket_object" "main" {
  name         = "${var.name}-${data.archive_file.main.output_md5}.zip"
  bucket       = var.artifacts_bucket_name
  source       = data.archive_file.main.output_path
  content_type = "application/zip"

  depends_on = [
    data.archive_file.main
  ]
}
