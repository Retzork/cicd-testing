# CI/CD Testing — Application Layer

This repo is deployed automatically to Azure App Service via a Self-Hosted GitHub Actions Runner.

## Structure

```
cicd-testing/
├── app/                    # Application code
│   ├── index.html          # Static web page
│   └── server.js           # Node.js HTTP server
├── infra/                  # Application infrastructure (Terraform)
│   ├── main.tf             # App Service Plan + Web App
│   ├── variables.tf        # Variables
│   └── outputs.tf          # Outputs
└── .github/workflows/
    └── deploy.yml          # CI/CD pipeline
```

## How It Works

1. Push to `main` → GitHub triggers the workflow
2. Self-hosted runner (on Azure VM) picks up the job
3. `az login --identity` authenticates via Managed Identity (zero secrets)
4. `terraform apply` ensures App Service infrastructure exists
5. `az webapp deploy` pushes the app code

## Two-Layer Architecture

```
Layer 1: Platform (managed locally by developer)
  → VM, UAMI, VNet, NSG, Storage Account
  → State: LOCAL on developer machine
  → Repo: terraform-journey/12 SelfHosted CICD Bridge

Layer 2: Application (managed by pipeline) ← THIS REPO
  → App Service Plan, Web App
  → State: REMOTE in Azure Storage
  → Repo: Retzork/cicd-testing
```

Layer 1 builds the pipeline. Layer 2 is what the pipeline deploys. They never interfere with each other.

## No Secrets in GitHub

All values in `deploy.yml` are public identifiers (subscription ID, client ID, resource names). Authentication happens via IMDS on the VM — no secrets stored anywhere.
