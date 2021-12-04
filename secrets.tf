# SPDX-FileCopyrightText: 2021 Valentyn Nastenko <versus.dev@gmail.com>
#
# SPDX-License-Identifier: MIT

data "vault_generic_secret" "secret" {
  path = "secret/application"
}

resource "random_password" "password" {
  count   = 3
  length  = 16
  special = true
}

locals {
  secret_json = jsondecode(data.vault_generic_secret.secret.data_json)

  chat_storage_roles = tolist(toset([
    "dev",
    "migration",
  ]))

  chat_storage_passwords = tolist(toset([
    random_password.password[0].result,
    random_password.password[1].result,
  ]))

  pair = {
    "ROOT_PASSWORD" = random_password.password[2].result
    "ROOT_USER"     = "admin"
    "MASTER"        = "slave"
  }

  ch_map    = zipmap(local.chat_storage_roles, local.chat_storage_passwords)
  data_json = jsonencode(merge(local.secret_json, local.ch_map, local.pair))
}

resource "vault_generic_secret" "secret" {
  path      = data.vault_generic_secret.secret.path
  data_json = local.data_json
}

output "dev_passwd" {
  value     = local.secret_json["VAULT_SECRET"]
  sensitive = true
}

output "data_json" {
  value     = local.data_json
  sensitive = true
}



