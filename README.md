*Work in Progress*

# secure-sdlc
Repository for showing a Secure Softwared Development Lifecyle


## Goals
- Build Container Image and Deploy within AWS ECS
- Build EC2 Instance with webserver via script at launch
- Allow EC2 Insance to be pubically exposed 

## Technologies Used:
- Terraform
- Docker
- Terraform Cloud
- AWS
- Prisma Cloud
    - IaC Scanning with Checkov via IDE Plugin
    - IaC Tagging with Yor via GitHub Action @ Pull Request 
    - IaC Scanning with Checkov via GitHub Action @ Pull Request
    - IaC Tagging with Yor via GitHub Action @ Push to Main Branch
    - IaC Scanning with Checkov via GitHub Action @ Push to Main Branch
    - Image Scanning at Commit via Defender @ Push to Main Branch
    - IaC Scanning with Checkov via Integration with Terraform Cloud
    - Scanning Images in Container Image Registry
    - Scanning for CI/CD Risk within Pipeline
    - Continuous Scanning of Configurations in AWS environment
    - Continuous Workload Vulnerability Scanning of cloud workloads


 


## Links
- [How Prisma Cloud Secures Cloud Native App Development with DevOps Plugins](https://www.paloaltonetworks.com/blog/prisma-cloud/cloud-devops-plugins)