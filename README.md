# Kubernetes The Hard Way as Code

Deploy [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) as Code, with Terraform and Ansible.

### The Big Picture

Applying all the manifests successfully will create 6 VMs in GCP and Kubernetes Cluster on top of them, with 3 Controllers and 3 Workers.  
The steps to create the Infra and the Cluster are identical to the great guide [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way).  

Modifying the enviroment (eg. changing the number of Nodes or the IP ranges etc.) is possible with great ease from the variables files on each project. Pay attention to apply the same changes though in each folder, so the enviroments will match (eg. reducing the number of Controllers in GCP Infra will require similar changes for the Cluster Deployment)

### Requirements

- GCP Account and Project ready
- Terraform Cloud (or Terraform CLI), configured with the GCP Project and the GitHub repo.
- Ansible (with kubernetes module)
- kubectl
- cfssl (for the creation of the Kubernetes licenses/keys)

### Steps

For further details on each step visit the corresponing folder:
01. [Build IaC on GCP with Terraform](https://github.com/xvag/k8s-iac-thw/tree/main/gcp)
02. [Deploy Kubernetes Cluster with Ansible](https://github.com/xvag/k8s-iac-thw/tree/main/cluster)
