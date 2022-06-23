# Deploy Kubernetes Cluster on GCP with Ansible for KTHWaC

Create the Kubernetes Cluster on the [GCP Infra](https://github.com/xvag/k8s-iac-thw/tree/main/gcp) created from the previous step.  

- Deploy with:  
`$ ansible-playbook deploy-cluster.yml`  

- Use tags included in the playbook to execute certain steps.  

- Successful deployment will also configure remote access to the Kubernetes Cluster, from the host that runs the playbook.  

- Changes in the Deployment are possible by changing the values in the vars.yml file. But be careful to match the values of the [GCP Infra](https://github.com/xvag/k8s-iac-thw/tree/main/gcp) in the previous step.

### Requirements

- [GCP Infra](https://github.com/xvag/k8s-iac-thw/tree/main/gcp) from previous step
- gcloud CLI (connected to the GCP Project)
- Ansible (with kubernetes module)
- kubectl
- cfssl (for the creation of the Kubernetes licenses/keys)
