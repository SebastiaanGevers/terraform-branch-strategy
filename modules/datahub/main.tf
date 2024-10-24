resource "helm_release" "datahub-prerequisites" {
  name = "prerequisites"
  repository = "https://helm.datahubproject.io/"
  chart = "datahub-prerequisites"

  values = [ "${file(var.datahub-prerequisites-values-file)}" ]

  depends_on = [ kubernetes_secret.neo4j-secret ]
}

resource "kubernetes_secret" "neo4j-secret" {
  metadata {
    name = "neo4j-secrets"
  }

  data = {
    neo4j_username = var.neo4j_username
    neo4j-password = var.neo4j_password
    NEO4J_AUTH = "${var.neo4j_username}/${var.neo4j_password}"

  }

  type = "Opaque"
}

locals {
  datahub_values = templatefile(
    var.datahub-values-file,
    {
      postgres_fqdn = var.postgres_fqdn,
      postgres_port = var.postgres_port,
      db_name = var.postgres_db_name,
      postgres_login = var.postgres_login
    })
}

resource "helm_release" "datahub" {
  name = "datahub"
  repository = "https://helm.datahubproject.io/"
  chart = "datahub"

  values = [ local.datahub_values ]

  depends_on = [ 
    helm_release.datahub-prerequisites,
    kubernetes_secret.postgresql-secrets,
    kubernetes_secret.default-credentials
  ]
}

resource "kubernetes_secret" "postgresql-secrets" {
  metadata {
    name = "postgresql-secrets"
  }

  data = {
    postgres-password = var.postgres_password
  }

  type = "Opaque"
}

resource "kubernetes_secret" "default-credentials" {
  metadata {
    name = "datahub-users-secret"
  }

  data = {
    "user.props" = "${var.datahub_root_user}:${var.datahub_root_user_password}"
  }

  type = "Opaque"
}