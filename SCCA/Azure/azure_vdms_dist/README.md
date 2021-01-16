# Prerequisites

•	Valid Azure Subscription
•	Access to Azure Cloud Shell

#Deploying on your deployment method, there are several changes that will need to be made prior to running the terraform in Azure Cloud Shell. The key changes will be 

•	License Type (BYOL, Bundle1, Bundle 2)
    Edit the terraform.tfvars and uncomment the appropriate license 
•	Region
• License for the firewall (pre or post deployment)
•	Panorama bootstrap

Deploy Build
$ terraform init
$ terraform apply


How to Destroy
Run the following to destroy the build.

$ terraform destroy
