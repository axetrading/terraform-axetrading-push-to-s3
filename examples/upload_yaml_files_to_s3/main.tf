module "axetrading" {
  source       = "../../"
  config_paths = var.config_paths # you can add multiple paths
  bucket_name  = var.bucket_name
}