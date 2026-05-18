# CI/CD Testing - Self-Hosted Runner Bridge

This repository demonstrates deploying to Azure using a **Self-Hosted GitHub Actions Runner** with a **Managed Identity** — no Service Principal, no OIDC, no secrets.

## How It Works

1. Push to `main` triggers the workflow
2. The job runs on `self-hosted` (a VM in Azure)
3. The VM authenticates via `az login --identity` (IMDS token)
4. Azure CLI commands execute with Contributor permissions

## No Secrets Required

The runner VM has a User-Assigned Managed Identity attached. Authentication happens locally via the Instance Metadata Service — there are zero secrets stored in GitHub.
