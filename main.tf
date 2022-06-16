provider "yandex" {
  token     = var.auth_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

# Create Container Registry
resource "yandex_container_registry" "registry" {
  name      = "container-registry"
  folder_id = var.folder_id
}

# Create SA
resource "yandex_iam_service_account" "sa" {
  name      = "registry-sa"
  folder_id = var.folder_id
}

# Grant permissions
resource "yandex_container_registry_iam_binding" "editor" {
  registry_id = yandex_container_registry.registry.id
  role        = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}
