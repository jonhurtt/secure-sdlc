*Work in Progress*

# secure-sdlc
Repository for showing a Secure Software Development Lifecyle

## Goals
1. Build Container Image and push to Amazon Elastic Container Registry (ECR)
1. Deploy Conatiner Image within Amazon Elastic Container Service (ECS)
1. Build Amazon Elastic Compute Cloud (EC2) Instance with webserver via script at launch and deploy using Terraform Cloud

## Technologies Used:
- Terraform
- Docker
- GitHub (VCS)
- GitHub Actions (CI)
- Terraform Cloud (CD)
- Amazon Elastic Container Registry (ECR)
- Amazon Elastic Compute Cloud (Amazon EC2)
- Amazon Elastic Container Service (ECS)

## Security Provided by Prisma Cloud
List of Security Functions provided by Prisma Cloud
### Secure the Source
1. IaC Scanning with Checkov via IDE Plugin
1. IaC Tagging with Yor via GitHub Action @ Pull Request 
1. IaC Scanning with Checkov via GitHub Action @ Pull Request
1. IaC Tagging with Yor via GitHub Action @ Push to Main Branch
1. IaC Scanning with Checkov via GitHub Action @ Push to Main Branch

### Secure @ Build & Deploy
1. Image Scanning at Commit via Defender @ Push to Main Branch
1. IaC Scanning with Checkov via Integration with Terraform Cloud
1. Scanning Images in Container Image Registry

### Secure the Runtime
1. Scanning for CI/CD Risk within Pipeline
1. Continuous Scanning of Configurations in AWS environment
1. Continuous Workload Vulnerability Scanning of cloud workloads

## Information for Deployment
- Ensure repository is public or part of GitHub Enterprise for GitHub Code Security Integration 
    - [About GitHub Code Scanning Integration](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning)
- Configure GitHub Actions to allow for Write Permissions (Settings->Actions->General->Under "Workflow permissions"->Enable "Read and Write Permissions")

### Integration with AWS
- Configure GitHub Action Secret - `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
- Configure GitHub Action Variables - `AWS_ECR_REPOSITORY`

### Integrations with Terraform Cloud
- Configure GitHub Action Secret - `TF_API_TOKEN`
- Configure GitHub Action Variables - `TERRAFORM_CLOUD_WORKSPACE` and `TERRAFORM_CLOUD_ORG`

### Integrations with Prisma Cloud
- Information for GitHubAction for IaC Tagging - [yor-action](https://github.com/bridgecrewio/yor-action)
- Configure GitHub Action Secret for IaC Scanning - `BC_API_KEY`
    - [checkov-action](https://github.com/bridgecrewio/checkov-action)
- Configure GitHub Action Secret for Image Scanning - `PCC_CONSOLE_URL`, `PCC_PASS` and `PCC_USER`
    - [prisma-cloud-scan](https://github.com/PaloAltoNetworks/prisma-cloud-scan)
    - [legacy github action](https://github.com/twistlock/sample-code/tree/master/CI/GitHub)

## Links & Resources
- [Automate Terraform with GitHub Actions](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)
- [Docker Docs - Containerizing an Application ](https://docs.docker.com/get-started/)
- [Github Action to AWS ECR (Docker Image) | Full Hands-on Tutorial](https://www.youtube.com/watch?v=yv8-Si5AB3U)
- [How Prisma Cloud Secures Cloud Native App Development with DevOps Plugins](https://www.paloaltonetworks.com/blog/prisma-cloud/cloud-devops-plugins)
- [Automated Container Image Scanning with the Prisma Cloud GitHub Action](https://www.paloaltonetworks.com/blog/prisma-cloud/github-action-container-image-scanning/)
- [How to Deploy a Dockerised Application on AWS ECS With Terraform](https://medium.com/avmconsulting-blog/how-to-deploy-a-dockerised-node-js-application-on-aws-ecs-with-terraform-3e6bceb48785)
- [Bridgecrew Workshop - Yor Tag & Trace ](https://workshop.bridgecrew.io/terraform/40_module_two/2002_yor_github_action.html)

## Inspiration
- [https://github.com/jcallowaypanw/cloud-security-aws-environement](https://github.com/jcallowaypanw/cloud-security-aws-environement)
- [https://github.com/try-panwiac/vulnerable-front-end](https://github.com/try-panwiac/vulnerable-front-end)