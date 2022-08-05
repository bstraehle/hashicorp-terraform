terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = "<token>"
}

resource "github_repository" "example" {
  name        = "terraform-repo"
  visibility  = "private"
}
