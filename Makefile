validate-dependencies:
	@scripts/validate-dependencies
.PHONY: validate-dependencies

bootstrap:
	@if [ -z "${ENV}" ]; then \
		echo "env is not set" >&2; \
		exit 1; \
	fi
	@echo "bootstrapping environment: ${ENV}..."
	@terragrunt apply --terragrunt-working-dir "terraform/1-env/${ENV}"
	@echo "initializing terraform state for environment: ${ENV}..."
	@STATE_BUCKET_NAME=$$(terragrunt output --terragrunt-working-dir "terraform/1-env/${ENV}" -raw terraform_state_bucket_name) \
		terragrunt init -reconfigure --terragrunt-working-dir "terraform/1-env/${ENV}"
	@echo "bootstrap complete"
.PHONY: bootstrap

cleanup-dependencies:
	@find . -type d -name ".terraform" -exec rm -rf {} \+
	@echo "✅ terraform files cleaned up..."
.PHONY: cleanup-dependencies

cleanup:
	echo "cleaning up infrastructure..."
	@find . -type f -name "backend.tf" -exec rm -rf {} \+
	@find . -type d -name ".terraform" -exec rm -rf {} \+
	@find . -type f -name "errored.tfstate" -exec rm -rf {} \+
	@find . -type f -name "terraform.tfstate" -exec rm -rf {} \+
	@echo "✅ infrastructure cleaned up..."
.PHONY: cleanup