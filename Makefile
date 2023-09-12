include make-services-app.mk

compose:
	docker compose up -d

compose-build:
	docker-compose build

setup-cloud:
	terraform apply -var-file=secrets.tfvars

destroy:
	terraform destroy -var-file=secrets.tfvars

import:
	terraform import -var-file=secrets.tfvars $(T)

create-token:
	bin/y_create_token

helth-check:
	ansible all -i inventory.ini --vault-password-file files/vault_pass -u $$USER -m ping

ansible-playbook:
	ansible-playbook $(P) -i inventory.ini -u $$USER -t $(T)

setup-nginx:
	# make ansible-playbook P="playbooks/setup_nginx.yml" T="system"
	make ansible-playbook P="playbooks/setup_nginx.yml" T="nginx"

create-users:
	ansible-playbook playbooks/system.yml -i inventory.ini -u $$USER

setup-app:
	ansible-playbook playbooks/main.yml -i inventory.ini --vault-password-file files/vault_pass -u $$USER

configure-terraform:
	ansible-playbook playbooks/terraform.yml -i inventory.ini --vault-password-file files/vault_pass  -u $$USER

setup-environment:
	ansible-playbook playbooks/environment.yml -i inventory.ini --vault-password-file files/vault_pass  -u $$USER
