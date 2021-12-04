# SPDX-FileCopyrightText: 2021 Valentyn Nastenko <versus.dev@gmail.com>
#
# SPDX-License-Identifier: MIT

variable "vault_address" {
  type    = string
  default = "http://127.0.0.1:8200"
}
variable "vault_token" {
  type = string
}