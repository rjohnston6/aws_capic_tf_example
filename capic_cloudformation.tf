terraform {
  required_version = "~>1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_credential_profile
}

resource "aws_cloudformation_stack" "capic_stack" {
  name = var.capic_stack_name

  parameters = {
    pFabricName       = var.pFabricName
    pInfraVPCPool     = var.pInfraVPCPool
    pAvailabilityZone = var.pAvailabilityZone
    pInstanceType     = var.pInstanceType
    pPassword         = var.pPassword
    pConfirmPassword  = var.pPassword
    pKeyName          = var.pKeyName
    pExtNw            = var.pExtNw
    pAssignOOBIntfEIP = var.pAssignOOBIntfEIP
  }
  template_url = var.capic_template_url
  # disable_rollback = false
  # on_failure       = "DO_NOTHING"
  # iam_role_arn     = ""

  capabilities = ["CAPABILITY_NAMED_IAM"] # CAPABILITY_NAMED_IAM required for cAPIC Stack
}

output "stack_outputs" {
  description = "Outputs from the Stack execution"
  value       = aws_cloudformation_stack.capic_stack.outputs
}
