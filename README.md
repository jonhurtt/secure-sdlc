*Work in Progress*


Repository for showing a Secure Software Development Lifecyle

## Goals
1. Build Container Image and push to Amazon Elastic Container Registry (ECR)
1. Build Amazon Elastic Compute Cloud (EC2) Instance with webserver (from [html/index.html](https://github.com/jonhurtt/secure-sdlc/blob/main/html/index.html)) via script at launch and deploy using Terraform Cloud
1. Deploy Conatiner Image within Amazon Elastic Container Service (ECS)

## Technologies Used:
- Docker (Code)
- Terraform (IaC)
- GitHub (VCS)
- GitHub Actions (CI)
- [Terraform Cloud (CD)](https://app.terraform.io/session)
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
- Configure GitHub Action Variables - `PRISMA_API_URL`
    - [checkov-action](https://github.com/bridgecrewio/checkov-action)
- Configure GitHub Action Secret for Image Scanning - `PCC_CONSOLE_URL`, `PCC_PASS` and `PCC_USER`
    - [prisma-cloud-scan](https://github.com/PaloAltoNetworks/prisma-cloud-scan)
    - [legacy github action](https://github.com/twistlock/sample-code/tree/master/CI/GitHub)

## GitHub Action Workflows
### On Pull Request
1. [![[step] IaC Yor Tagging on Push](https://github.com/jonhurtt/secure-sdlc/actions/workflows/yor_tagging_on_push.yml/badge.svg)](https://github.com/jonhurtt/secure-sdlc/actions/workflows/yor_tagging_on_push.yml)
1. [![[step] Scan Image on Push](https://github.com/jonhurtt/secure-sdlc/actions/workflows/twstcli_image_scan_on_push.yml/badge.svg)](https://github.com/jonhurtt/secure-sdlc/actions/workflows/twstcli_image_scan_on_push.yml)
1. [![[step] Terraform Plan on Pull](https://github.com/jonhurtt/secure-sdlc/actions/workflows/terraform_plan_on_pull.yml/badge.svg)](https://github.com/jonhurtt/secure-sdlc/actions/workflows/terraform_plan_on_pull.yml)

### On Push
1.[![[step] Checkov (IaC/SCA) Scan on Push](https://github.com/jonhurtt/secure-sdlc/actions/workflows/checkov_iac_sca_scan_on_push.yml/badge.svg)](https://github.com/jonhurtt/secure-sdlc/actions/workflows/checkov_iac_sca_scan_on_push.yml)
1. [![[step] Checkov Image Scan on Push](https://github.com/jonhurtt/secure-sdlc/actions/workflows/checkov_image_scan_on_push.yml/badge.svg)](https://github.com/jonhurtt/secure-sdlc/actions/workflows/checkov_image_scan_on_push.yml)
1. [![[step] Push Image to AWS ECR on Push](https://github.com/jonhurtt/secure-sdlc/actions/workflows/push_image_to_aws_ecr_on_push.yml/badge.svg)](https://github.com/jonhurtt/secure-sdlc/actions/workflows/push_image_to_aws_ecr_on_push.yml)
1. [![[step] Terraform Apply on Push](https://github.com/jonhurtt/secure-sdlc/actions/workflows/terraform_apply_on_push.yml/badge.svg)](https://github.com/jonhurtt/secure-sdlc/actions/workflows/terraform_apply_on_push.yml)


## Links & Resources
- [Install Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Automate Terraform with GitHub Actions](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)
- [Docker Docs - Containerizing an Application ](https://docs.docker.com/get-started/)
- [Github Action to AWS ECR (Docker Image) | Full Hands-on Tutorial](https://www.youtube.com/watch?v=yv8-Si5AB3U)
- [How Prisma Cloud Secures Cloud Native App Development with DevOps Plugins](https://www.paloaltonetworks.com/blog/prisma-cloud/cloud-devops-plugins)
- [Automated Container Image Scanning with the Prisma Cloud GitHub Action](https://www.paloaltonetworks.com/blog/prisma-cloud/github-action-container-image-scanning/)
- [How to Deploy a Dockerised Application on AWS ECS With Terraform](https://medium.com/avmconsulting-blog/how-to-deploy-a-dockerised-node-js-application-on-aws-ecs-with-terraform-3e6bceb48785)
- [Bridgecrew Workshop - Yor Tag & Trace ](https://workshop.bridgecrew.io/terraform/40_module_two/2002_yor_github_action.html)
- [Create and manage an AWS ECS cluster with Terraform](https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Cloud Workflows for GitHub](https://github.com/hashicorp/tfc-workflows-github)
- [Terraform AWS modules](https://github.com/terraform-aws-modules)
- [Create Amazon EKS Cluster using Terraform Module](https://dev.to/aws-builders/create-amazon-eks-cluster-using-terraform-module-27p5)

## Inspiration
- [https://github.com/jcallowaypanw/cloud-security-aws-environement](https://github.com/jcallowaypanw/cloud-security-aws-environement)
- [https://github.com/try-panwiac/vulnerable-front-end](https://github.com/try-panwiac/vulnerable-front-end)

## Base Repos (Building Blocks)
- Build Container Image and push to Amazon Elastic Container Registry (ECR) with Image Scanning
    - [https://github.com/jonhurtt/pc-container-image-scan](https://github.com/jonhurtt/pc-container-image-scan)
- Build Amazon Elastic Compute Cloud (EC2) Instance with webserver via script at launch and deploy using Terraform Cloud with Yor Tagging & Checkov Scanning
    - [https://github.com/jonhurtt/github-terraform-aws](https://github.com/jonhurtt/github-terraform-aws)

## Roadmap
- Add additional resources within main.tf or expand to a more complex environment
- Increase Runtime Security with auto deploy of Prisma Cloud Defender
- Look into Trusted Images within Prisma Cloud
- Look into [Deploy infrastructure with Terraform and CircleCI](https://developer.hashicorp.com/terraform/tutorials/automation/circle-ci)
- Look into [Deploy Consul and Vault on Kubernetes with run triggers](https://developer.hashicorp.com/terraform/tutorials/automation/kubernetes-consul-vault-pipeline)

## Clean Up
- Commands to replace tf with non-tagged tf
    - `cp build_apache_ec2.untagged-tf build_apache_ec2.tf`
    - `cp build_aws_ecs.untagged-tf build_aws_ecs.tf`
