# TypeScript Node.js API

A simple TypeScript Node.js API with API key authentication, designed to be deployed on AWS EC2.

## Features

- TypeScript-based Express API
- API key authentication
- Docker for local development
- Terraform for infrastructure as code
- GitHub Actions for CI/CD
- PNPM for package management

## Local Development

### Prerequisites

- Node.js (v14+)
- PNPM package manager
- Docker and Docker Compose
- AWS CLI (for deployment)
- Terraform (for infrastructure provisioning)

### Running Locally

```bash
# Install dependencies
pnpm install

# Run in development mode
pnpm dev
```

### Running with Docker

```bash
# Build and start the Docker containers
docker-compose up

# To rebuild
docker-compose up --build
```

## API Authentication

The API is protected with API key authentication. Include the API key in the request header:

```
X-API-KEY: your-api-key
```

## Deployment

### Manual Deployment

1. Set up your AWS credentials
2. Run Terraform to provision infrastructure:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

### Automated Deployment

The project includes a GitHub Actions workflow that automatically deploys to EC2 when changes are pushed to the main branch.

## Configuration

Configuration settings can be adjusted in the `.env` file or by setting environment variables. 