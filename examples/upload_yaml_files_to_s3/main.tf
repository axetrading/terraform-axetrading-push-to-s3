module "axetrading" {
  source       = "../../"
  config_paths = ["./configs"] # you can add multiple paths
  bucket_name  = "resources-configurations"
}