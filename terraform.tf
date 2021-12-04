# SPDX-FileCopyrightText: 2021 Valentyn Nastenko <versus.dev@gmail.com>
#
# SPDX-License-Identifier: MIT

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
}


provider "vault" {
  address         = var.vault_address
  token           = var.vault_token
  skip_tls_verify = true
}

provider "random" {
}