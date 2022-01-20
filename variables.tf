
### AWS variables

variable "aws_region" {
  description = "AWS Region for resource deployment"
  type        = string
  default     = "us-east-1"
}

variable "aws_credential_profile" {
  description = "Set credential profile for aws cli if not using default"
  type        = string
  default     = "default"
}


### Cloud ACI variables

variable "capic_template_url" {
  description = "CloudFormation template URL for CAPIC"
  type        = string
  default     = "https://s3.amazonaws.com/awsmp-fulfillment-cf-templates-prod/6cad9a0e-821a-4f03-881e-fb1f66f4dc1f/701f86dae59c46b1994f687f85e0aca3.template"
}

variable "capic_stack_name" {
  description = "CloudFormation deployment stack name"
  type        = string
  default     = "capic-stack"

  validation {
    condition     = !can(regex("[^-a-zA-Z0-9]", var.capic_stack_name))
    error_message = "Stack name must be alphanumeric with no special characters except '-'."
  }
}

variable "pFabricName" {
  description = "Fabric Name (must be only alphanumeric chars separated by '-')"
  type        = string
  default     = "ACI-Cloud-Fabric"

  validation {
    condition     = length(var.pFabricName) >= 4 && length(var.pFabricName) <= 64
    error_message = "Must be a minimum of 4 and a maximum of 64 characters, no special characters except '-'!"
  }
}

variable "pInfraVPCPool" {
  description = "IP address pool for Infra VPCs (must be a /24 prefix)"
  type        = string
  default     = "10.10.0.0/24"

  validation {
    condition     = can(regex("(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\/24", var.pInfraVPCPool))
    error_message = "Must be a valid IP CIDR range of the form x.x.x.x/24."
  }
}

variable "pAvailabilityZone" {
  description = "Availability zone for Cloud APIC (Must select lexicographically lowest Availability zone)"
  type        = string
  default     = "us-east-1a"

}

variable "pInstanceType" {
  description = "Select one of the possible EC2 instance types"
  type        = string
  default     = "m5.2xlarge"

  validation {
    condition     = (var.pInstanceType) == "m5.2xlarge" || (var.pInstanceType) == "m4.2xlarge"
    error_message = "AllowedValues: m4.2xlarge or m5.2xlarge."
  }
}

variable "pPassword" {
  description = "Admin Password for Cloud APIC"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.pPassword) >= 8
    error_message = "Password should contain 8 Characters or more, Atleast 1 letter, number and special character '@$!%*#?&'."
  }
}

variable "pKeyName" {
  description = "Name of an existing SSH KeyPair to enable SSH access to Cloud APIC"
  type        = string
}

variable "pExtNw" {
  description = "External network allowed to access Cloud APIC (x.x.x.x/x). Configuring external subnet with 0.0.0.0/0 is a SECURITY RISK, it is advisable to use specific subnet."
  type        = string

  validation {
    condition     = can(regex("(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\/(\\d{1,2})", var.pExtNw))
    error_message = "Must be a valid IP subnet of the form x.x.x.x/x."
  }
}

variable "pAssignOOBIntfEIP" {
  description = "Select whether to assign public IP address to oob management interface or not."
  type        = string
  default     = "true"

  validation {
    condition     = (var.pAssignOOBIntfEIP) == "true" || (var.pAssignOOBIntfEIP) == "false"
    error_message = "Must be set to either true or false."
  }
}
