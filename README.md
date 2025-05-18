# SMT Take Home Exercise
This project walks through the implementation of Terraform/Terragrunt to complete a Take-Home Assessment, working with multiple Google Cloud services, including Cloud Functions and Load Balancing. It also highlights effective Terraform module structuring and management.

## Overview
The repository contains multiple Terraform projects, each fulfilling a specific infrastructure objective and numbered from 1 to 3.

Each step is further divided into environments, which serve to separate the infrastructure of multiple environments in one place. This is also useful for deploying the complete infrastructure by environment without affecting others.

### 1-env
This step performs the creation of the environment based on the arguments passed to the module, currently only accepting values dev, tst, and prd. This step handles the bootstrapping of the environment, creating the project, and necessary dependencies to support the development and deployment of services.

### 2-network
This step performs the network configuration, creating a VPC with a default route to the internet, in addition to creating the necessary subnets to deploy resources in services such as Compute Engine, Cloud SQL, GKE, etc.

This step includes:
- VPC Network
- Subnets
- Firewall rules

### 3-units
This step handles the creation of specific business units for the project, such as Load Balancers, Cloud Run functions, Databases, etc.

This step includes:
- `hello-world` module: Cloud Run Function, Serverless VPC Connector and IAM configuration.
- `ingress` module: Load Balancer, URL Map and Cloud Armor configuration.

## Requirements
To execute this project, you need to have the following installed:
- Google Cloud SDK
- Git
- Terraform
- Terragrunt

Additionally, you must have the following resources in Google Cloud:
- Billing Account
- Bootstrap Project

### Bootstrap project dependencies:
Since the use of GCP APIs are subject to quotas, it is necessary to have a bootstrap project to associate them with. For this, the following APIs must be enabled in that project:
- `cloudresourcemanager.googleapis.com`
- `iam.googleapis.com`
- `compute.googleapis.com`
- `cloudfunctions.googleapis.com`
- `run.googleapis.com`
- `storage-api.googleapis.com`
- `cloudbuild.googleapis.com`
- `vpcaccess.googleapis.com`

You can enable them using the following commands:
```bash
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable storage-api.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable vpcaccess.googleapis.com
```

## Provision Resources
The following steps explain in detail how to execute and provision the resources in this project:

1. Run make validate-dependencies. This command will verify if you have the necessary dependencies.

2. Make a copy of the example.secrets.hcl file.
```bash
cp terraform/example.secrets.hcl terraform/secrets.hcl
```

3. Fill in the default values in secrets.hcl or configure the following environment variables in your system.
```bash
export BILLING_PROJECT_ID="<value>"
export BILLING_ACCOUNT_ID="<value>"
```

4. Configure the base name and environment for the project. Currently, only the `dev` environment is configured, but other environments can be easily set up.
```bash
export NAME="<value>"
export ENV="dev"
```

5. Run the `make bootstrap command`. This command handles the first step, which is to create the project in Google Cloud, along with the buckets to store the source code for Cloud Run Functions and the Terraform state.
```bash
make bootstrap
```

6. Configure the environment variable that points to the remote backends in GCS. Ensure that the environment variables from the previous steps are configured.
```bash
export STATE_BUCKET_NAME=$(terragrunt output --terragrunt-working-dir "terraform/1-env/${ENV}" -raw terraform_state_bucket_name)
```

7. Execute the provisioning of the remaining infrastructure.
```bash
terragrunt run-all apply --terragrunt-include-dir "**/${ENV}"
```
