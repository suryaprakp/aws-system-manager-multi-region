# AWS Systems Manager

This repo is used to manage Infrastructure as code for AWS systems manager service . This will deploy resources to multi-regions using terraform workspaces

## Pre-requisites
* Terraform version specified in `Make-terraform`
* AWS Credentials 

## How to use 

* **AWS Credentials:** Make sure that your AWS credentials are set and profile is exported.
`export AWS_DEFAULT_PROFILE=profile-name`

* **Terraform workspaces**:
As this project is deployed multi-region , the tf state is maintained through workspaces with each region name as a new workspace name .
    * **Lab**: As we have only one region eu-central-1 , Default workspace is mapped to eu-central-1 region , which doesnt require to use new workspace
    * **Prod**: Currently project is deployed to 5 regions , workspace to region mapping is as follows

        | Workspace name | Region |
        |------|-------------|
        | default | eu-central-1 | 
        | us-east-1    | us-east-1 |  
        | ap-southeast-1 | ap-southeast-1 | 
        | ap-southeast-2 | ap-southeast-2 |
        | sa-east-1 | sa-east-1 |
  
        * If project needs to be deployed in another region , you need to add variable map in `variables_mandatory.tf` and region name in `terraform_execute.sh`
            ```
            # To execute plan on all regions
            terraform_execute.sh plan 

            # To execute apply on all regions
            terraform_execute.sh apply 
            ```