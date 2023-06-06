setup-cloud:
	terraform apply -var-file=secrets.tfvars

destroy:
	terraform destroy -var-file=secrets.tfvars

import:
	terraform import -var-file=secrets.tfvars $(T)

create-token:
	yc iam create-token

helth-check:
	ansible all -i inventory.ini -u ubuntu -m ping

ansible-playbook:
	ansible-playbook $(P) -i inventory.ini -u ubuntu -t $(T)

setup-nginx:
	make ansible-playbook P="playbooks/setup_nginx.yml" T="system"
	make ansible-playbook P="playbooks/setup_nginx.yml" T="nginx"
