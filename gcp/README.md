# Build IaC on GCP with Terraform for KTHWaC

Create the Infrastructure on GCP, for a "Kubernetes The Hard Way" Deployment, using Terraform.  

- It will create 6 VMs on GCP: 3 for Controllers and 3 for Workers.  
- Controllers are on a different VPC from Workers, so VPC Peering is created.  
- Creates Target-Pool of the Controllers and Health Checks throught a Public IP Address.  
- Create Route rules for Pod Network in the Workers.  
- Also creates the necessary firewall rules, for inside the Cluster and external traffic.  
  Extra Firewall Ports can be added in .tfvars files.
- Creates ssh user/key as Project Metadata, for accessing all VMs through SSH.

Changes in the Infra are possible by changing the variables in .tfvars file.  
Tip: The number of instances for the VMs is defined by the number of IPs declared for that group of instances.  


### Requirements

- GCP Account and Project ready
- Terraform Cloud (or Terraform CLI), configured with the GCP Project and the GitHub repo.
