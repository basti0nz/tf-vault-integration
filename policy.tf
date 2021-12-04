# SPDX-FileCopyrightText: 2021 Valentyn Nastenko <versus.dev@gmail.com>
#
# SPDX-License-Identifier: MIT

resource "vault_password_policy" "database_password" {
  name   = "database_password"
  policy = file("vault_db_password_policy.hcl")

}


output "passwd" {
  value = vault_password_policy.database_password.name
}