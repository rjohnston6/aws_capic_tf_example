# Example Terraform Plan to deploy Cisco Cloud Application Policy Infrastructure Controller on AWS

This is an example terraform manifest that uses the terraform resource **aws_cloudformation_stack** to deploy the Cisco Cloud Application Policy Infrastructure Controller (cAPIC) using the provided CloudFormation template published on the AWS Marketplace.

To use this CloudFormation stack you must access the AWS Marketplace and subscribe and accept the terms and conditions prior to executing the apply, failure to do so will cause the execution to run for approximately 10 minutes then fail on deployment of the cAPIC Instance and roll back the stack deployment. 

Visit the following url to view details about Cisco cAPIC on the AWS Marketplace and to subscribe.

[AWS Marketplace - Cisco Cloud Infrastructure Controller](https://aws.amazon.com/marketplace/pp/prodview-2ik24m2crp3h4?sr=0-13&ref_=beagle&applicationId=AWSMPContessa)

## Note
When issuing a terraform destroy, the cloud stack will be set for deletion and process the delete process of the resources created as part of the CloudFormation template. In some occurances the destroy will fail at approximately 15 minutes. The failure reason will be displayed and will likely result in an issue deleting the VPC that is created. To resolve manually access the AWS console and remove the **_context-[overlay-1]-addr-[<vpc_cidr>]_** VPC then re-run the terraform destroy. It should execute and complete successfully.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.65.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.65.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.capic_stack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_credential_profile"></a> [aws\_credential\_profile](#input\_aws\_credential\_profile) | Set credential profile for aws cli if not using default | `string` | `"default"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region for resource deployment | `string` | `"us-west-2"` | no |
| <a name="input_capic_stack_name"></a> [capic\_stack\_name](#input\_capic\_stack\_name) | CloudFormation deployment stack name | `string` | `"capic-stack"` | no |
| <a name="input_capic_template_url"></a> [capic\_template\_url](#input\_capic\_template\_url) | CloudFormation template URL for CAPIC | `string` | `"https://s3.amazonaws.com/awsmp-fulfillment-cf-templates-prod/6cad9a0e-821a-4f03-881e-fb1f66f4dc1f.d84b3cb0-1de1-4ce6-48b1-08c415e60682.template"` | no |
| <a name="input_pAssignOOBIntfEIP"></a> [pAssignOOBIntfEIP](#input\_pAssignOOBIntfEIP) | Select whether to assign public IP address to oob management interface or not. | `string` | `"true"` | no |
| <a name="input_pAvailabilityZone"></a> [pAvailabilityZone](#input\_pAvailabilityZone) | Availability zone for Cloud APIC (Must select lexicographically lowest Availability zone) | `string` | `"us-west-2a"` | no |
| <a name="input_pExtNw"></a> [pExtNw](#input\_pExtNw) | External network allowed to access Cloud APIC (x.x.x.x/x). Configuring external subnet with 0.0.0.0/0 is a SECURITY RISK, it is advisable to use specific subnet. | `string` | n/a | yes |
| <a name="input_pFabricName"></a> [pFabricName](#input\_pFabricName) | Fabric Name (must be only alphanumeric chars separated by '-') | `string` | `"ACI-Cloud-Fabric"` | no |
| <a name="input_pInfraVPCPool"></a> [pInfraVPCPool](#input\_pInfraVPCPool) | IP address pool for Infra VPCs (must be a /24 prefix) | `string` | `"10.10.0.0/24"` | no |
| <a name="input_pInstanceType"></a> [pInstanceType](#input\_pInstanceType) | Select one of the possible EC2 instance types | `string` | `"m5.2xlarge"` | no |
| <a name="input_pKeyName"></a> [pKeyName](#input\_pKeyName) | Name of an existing SSH KeyPair to enable SSH access to Cloud APIC | `string` | n/a | yes |
| <a name="input_pPassword"></a> [pPassword](#input\_pPassword) | Admin Password for Cloud APIC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stack_outputs"></a> [stack\_outputs](#output\_stack\_outputs) | Outputs from the Stack execution |
<!-- END_TF_DOCS -->