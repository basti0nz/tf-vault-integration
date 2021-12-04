# SPDX-FileCopyrightText: 2021 Valentyn Nastenko <valentyn.nastenko@restream.io>
# SPDX-FileCopyrightText: 2021 RESTREAM.IO
#
# SPDX-License-Identifier: UNLICENSED

.PHONY: all

all: init plan apply

start:
	vault server -dev
init:
	terraform fmt -recursive
	terraform init -reconfigure -upgrade

plan:
	terraform plan --out tfplan.binary -refresh=true
	terraform show -json tfplan.binary > tfplan.json

p:
	terraform fmt -recursive
	terraform plan -refresh=true

apply: 
	terraform apply

check: init
	terraform plan -detailed-exitcode

destroy: init
	terraform destroy

docs:
	terraform-docs md . > README.md

kics:
	terraform fmt -recursive
	docker pull checkmarx/kics:latest
	docker run --rm -v $(CURDIR):/path checkmarx/kics:latest scan --path /path

checkov: plan
	checkov -f tfplan.json

