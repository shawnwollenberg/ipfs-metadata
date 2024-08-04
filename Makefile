.PHONY: fmt init plan apply destroy

# Default target executed when no arguments are given to make.
default: fmt

fmt:
	@echo "Changing directory to infrastructure..."
	cd infrastructure && \
		terraform fmt -recursive || (echo "Terraform files need formatting." && exit 1)

validate: fmt
	@echo "Changing directory to infrastructure..."
	cd infrastructure && \
		terraform validate

init: fmt
	@echo "Changing directory to infrastructure..."
	cd infrastructure && \
		terraform init -reconfigure 

plan: validate
	@echo "Changing directory to infrastructure..."
	cd infrastructure && \
		terraform plan

apply: validate
	@echo "Changing directory to infrastructure..."
	cd infrastructure && \
		terraform apply -var-file="terraform.tfvars" -auto-approve 

destroy: validate
	@echo "Changing directory to infrastructure..."
	cd infrastructure && \
		terraform destroy -var-file="terraform.tfvars" -auto-approve
