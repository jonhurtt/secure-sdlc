*Work in Progress*

# secure-sdlc
Repository for showing a Secure Softwared Development Lifecyle


## Goals
- Build Container Image and push to Amazon Elastic Container Registry (ECR)
- Deploy within Amazon Elastic Container Service (ECS)
- Build Amazon Elastic Compute Cloud (EC2) Instance with webserver via script at launch
- Allow Amazon Elastic Compute Cloud (EC2) Insance to be pubically exposed 

## Technologies Used:
- Terraform
- Docker
- GitHub
- GitHub Actions
- Terraform Cloud
- Amazon Elastic Container Registry (ECR)
- Amazon Elastic Compute Cloud (Amazon EC2)
- Amazon Elastic Container Service (ECS)

## Security Provided by Prisma Cloud
- List of Security Functions provided by Prisma Cloud
    1. IaC Scanning with Checkov via IDE Plugin
    1. IaC Tagging with Yor via GitHub Action @ Pull Request 
    1. IaC Scanning with Checkov via GitHub Action @ Pull Request
    1. IaC Tagging with Yor via GitHub Action @ Push to Main Branch
    1. IaC Scanning with Checkov via GitHub Action @ Push to Main Branch
    1. Image Scanning at Commit via Defender @ Push to Main Branch
    1. IaC Scanning with Checkov via Integration with Terraform Cloud
    1. Scanning Images in Container Image Registry
    1. Scanning for CI/CD Risk within Pipeline
    1. Continuous Scanning of Configurations in AWS environment
    1. Continuous Workload Vulnerability Scanning of cloud workloads

## Information for Deployment
- Ensure repository is public or part of GitHub Enterprise for GitHub Code Security Integration - [Read more here](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning)
### Integration with AWS
1. Configure GitHub Action Secret - AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

### Integrations with Terraform Cloud
1. Configure GitHub Action Secret - TF_API_TOKEN
1. Configure GitHub Action Variables - TERRAFORM_CLOUD_WORKSPACE and TERRAFORM_CLOUD_ORG


### Integrations with Prisma Cloud
1. Configure GitHub Action Secret for IaC Scanning - BC_API_KEY
1. Configure GitHub Action Secret for Image Scanning - PCC_CONSOLE_URL, PCC_PASS and PCC_USER

## Links
- [How Prisma Cloud Secures Cloud Native App Development with DevOps Plugins](https://www.paloaltonetworks.com/blog/prisma-cloud/cloud-devops-plugins)