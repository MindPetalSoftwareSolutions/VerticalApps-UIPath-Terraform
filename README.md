# Terraform & AWS => UiPath Orchestrator.
Steps to provision Orchestrator on AWS in ASG (Auto scaling group):
1. Install terraform  v0.12.3 (https://learn.hashicorp.com/terraform/getting-started/install.html).
2. Complete a variables.tf file (see inputs below these are just examples). For Orchestrator hardware requirements and EC2 types, check : https://aws.amazon.com/ec2/instance-types/  and https://orchestrator.uipath.com/docs/hardware-requirements-orchestrator.
3. Change directory to path of repository.
4. Run : ` export AWS_ACCESS_KEY_ID="accesskey" `
5. Run : ` export AWS_SECRET_ACCESS_KEY="secretkey" `
6. Run : ` export AWS_DEFAULT_REGION="us-east-1" `
7. Run : ` terraform init `
8. Run : ` terraform apply `
9. Check the plan of the resources to be deployed and type ` yes ` if you agree with the plan.
10. Wait 20-30 mins and enjoy! The password of the Orchestrator is the password used to ` orchestrator_password ` variable.
11. To tear down the infrastructure Run : ` terraform destroy `

## Terraform version
Terraform v0.12.3

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| key\_name | Name of the SSH keypair to use in AWS. | map | `<map>` | yes |
| aws\_app\_instance\_type | Orchestrator Instance type. | string | `"m4.large"` | yes |
| environment | Environment name, used as prefix to tag the name of the resources. | string | `"dev"` | yes |
| application | Application stack name, used as prefix to tag the name of the resources. | string | `"OrchestratorStack"` | yes |
| db\_username | RDS master user name. | string | `"devawsdb"` | yes |
| db\_password | RDS Master password. | string | `"!vfdgva%gsd"` | yes |
| db\_name | RDS database name. | string | `"awstest"` | yes |
| environment | Environment name, used as prefix to name resources. | string | `"dev"` | yes |
| rds\_allocated\_storage | The allocated storage in gigabytes. | string | `"100"` | yes |
| rds\_instance\_class | The instance type of the RDS instance. | string | `"db.m4.large"` | yes |
| rds\_multi\_az | Specifies if the RDS instance is multi-AZ. | string | `"false"` | yes |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. | string | `"true"` | yes |
| aws\_availability\_zones | Availability zones for each region | map | `<map>` | yes |
| orchestrator\_password | Orchestrator Administrator password to login in Default and Host Tennant. | string | `"0rCh35Tr@tor!"` | yes |
| orchestrator\_version | Orchestrator Version. | string | `"19.4.4"` | yes |
| admin\_password | Windows Administrator password used to login in the provisioned VMs. | string | `"WinP@55!"` | yes |
| orchestrator\_passphrase | Orchestrator Passphrase used to generate NuGet API keys, App encryption key and machine keys. | string | `"!asfgre2%gsd"` | yes |
| orchestrator\_license | Orchestrator license code. The license created with regutil. | string | `"TheLicenseCreatedwithRegUtil"` | yes |

## Outputs

| Name | Description |
|------|-------------|
| public\_ip | Public IP address assigned to the Orchestrator instance. |
| mssql\_id | Identifier of the mssql DB instance. |
| mssql\_address | Address of the mssql DB instance. |
| public\_dns | Public DNS name assigned to the Orchestrator instance. |
