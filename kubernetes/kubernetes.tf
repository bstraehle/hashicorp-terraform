terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.12.1"
    }
  }
}

data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../terraform-eks/terraform.tfstate"
  }
}

provider "aws" {
  region = data.terraform_remote_state.eks.outputs.region
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}

resource "kubernetes_deployment" "rest-api" {
  metadata {
    name = "rest-api"
    labels = {
      App = "rest-api"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "rest-api"
      }
    }
    template {
      metadata {
        labels = {
          App = "rest-api"
        }
      }
      spec {
        container {
          image = "bstraehle/rest-api"
          name  = "rest-api"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "mvc-app" {
  metadata {
    name = "mvc-app"
    labels = {
      App = "mvc-app"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "mvc-app"
      }
    }
    template {
      metadata {
        labels = {
          App = "mvc-app"
        }
      }
      spec {
        container {
          image = "bstraehle/mvc-app"
          name  = "mvc-app"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "rest-api" {
  metadata {
    name = "rest-api-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.rest-api.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8001
      target_port = 80
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "mvc-app" {
  metadata {
    name = "mvc-app-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.mvc-app.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8000
      target_port = 80
    }

    type = "NodePort"
  }
}
