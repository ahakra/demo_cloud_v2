# Variables
TF_DIR = IAC/Terraform
GCP_AUTH_CMD = gcloud auth activate-service-account $(DEMO_CLOUD_V2_USER) --key-file=$(DEMO_CLOUD_V2_KEY)
GCP_CONFIG_PROJECT_CMD = gcloud config set project $(DEMO_CLOUD_V2_PROJECT)
GCP_SET_ACCOUNT_CMD = gcloud config set account $(KUSER)

# =========================
# GCP Authentication & Configuration
# =========================

.PHONY: authgcp
authgcp: ## Authenticate GCP using a service account
	$(GCP_AUTH_CMD)

.PHONY: configproject
configproject: ## Configure GCP project
	$(GCP_CONFIG_PROJECT_CMD)

.PHONY: setgcpacc
setgcpacc: ## Set GCP account
	$(GCP_SET_ACCOUNT_CMD)

.PHONY: login
login: authgcp configproject setgcpacc ## Perform GCP login with account and project

# =========================
# Terraform Commands
# =========================

.PHONY: terraform/init
terraform/init: ## Initialize Terraform in the specified directory
	cd $(TF_DIR) && terraform init

.PHONY: terraform/plan
terraform/plan: ## Generate a Terraform execution plan
	cd $(TF_DIR) && terraform plan

.PHONY: terraform/apply
terraform/apply: ## Apply Terraform changes (add -auto-approve to skip confirmation)
	cd $(TF_DIR) && terraform apply

.PHONY: terraform/apply/auto
terraform/apply/auto: ## Apply Terraform changes without confirmation
	cd $(TF_DIR) && terraform apply -auto-approve

.PHONY: terraform/destroy
terraform/destroy: ## Destroy Terraform-managed infrastructure
	cd $(TF_DIR) && terraform destroy

.PHONY: terraform/destroy/partial
terraform/destroy/partial: ## Destroy specific Terraform resources (defined in target)
	cd $(TF_DIR) && terraform destroy -target google_compute_subnetwork.network-with-private-second-ip-ranges

.PHONY: terraform/state/list
terraform/state/list: ## List Terraform-managed resources in the state
	cd $(TF_DIR) && terraform state list

# =========================
# Help Section
# =========================

.PHONY: help
help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_/.-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'
