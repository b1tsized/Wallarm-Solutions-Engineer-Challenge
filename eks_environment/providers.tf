terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=6.6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=3.0.0"
    }
  }
}

### AWS ###

provider "aws" {
  region = var.region
  profile = var.profile
}

### Helm ###

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

