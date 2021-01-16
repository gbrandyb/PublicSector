# Prerequisites
•	Valid Azure Subscription
•	Access to Azure Cloud Shell


# How to Deploy
1. Setup & Download Build
In the Azure Portal, open Azure Cloud Shell and run the following BASH ONLY!.
# Accept VM-Series EULA for desired license type (BYOL, Bundle1, or Bundle2)
$ az vm image terms accept --urn paloaltonetworks:vmseries1:<byol><bundle1><bundle2>:10.0.3

# Download repo & change directories to the Terraform build
$ git clone https://github.com/PaloAltoNetworks/PublicSector; cd PublicSector/SCCA/Azure/azure_vdms_dist

2. Edit terraform.tfvars
Open terraform.tfvars and uncomment one value for fw_license that matches your license type from step 1.

$ vi terraform.tfvars
Your terraform.tfvars should look like this before proceeding 

3. Deploy Build
$ terraform init
$ terraform apply

How to Destroy
Run the following to destroy the build.

$ terraform destroy
