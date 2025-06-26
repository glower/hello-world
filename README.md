# Hello World

This is a mono-repo setup for a `hello-world` application.
* backend: contains code for the backend service, written in Golang
* frontend: contains code for the frontend application, written in Typescript
* pulumi: contains infra setup, it's terraform in Golang :)
* terraform: contains infra setup, using Terraform HCL

## CI/CD

CI/CD pipeline is managed by `Github Actions` and the config could be found in .github directory. 

On commit in `backend/` directory we run the pipeline for the backend services: test -> build -> push to Docker -> deploy to K8s. Same happens for the `frontend/` part.

## Setup

### Pulumi

* Run `pulumi` infra setup from `pulumi/` directory.
* Run `aws eks list-clusters` to get the name of the cluser.
* Add this name to the `workflows` files as `AWS_CLUSTER_NAME`
* Run `aws eks update-kubeconfig --name cluser_name`
* Run `kubectl get pods` to check the deployment.
* Run `kubectl get services` to get the public address (EXTERNAL-IP) of the service.
* Call the URL on `8080` port.
* http://ab768f8ee81c044aba45aedd16fe46d8-1338296734.eu-west-1.elb.amazonaws.com:8080/

### Terraform (GCP)

This directory contains the Terraform configuration for deploying the GKE cluster on Google Cloud Platform.

#### Prerequisites

*   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed
*   [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and configured with your credentials

#### Usage

1.  **Initialize Terraform:**
    ```bash
    cd terraform
    terraform init
    ```

2.  **Plan the changes:**
    ```bash
    terraform plan -var="gcp_project_id=your-gcp-project-id"
    ```
    This command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. Replace `your-gcp-project-id` with your actual GCP project ID.

3.  **Apply the configuration:**
    ```bash
    terraform apply -var="gcp_project_id=your-gcp-project-id"
    ```
    This will create the GKE cluster and associated resources. Enter `yes` when prompted to confirm.

4.  **Update kubeconfig:**
    After the `apply` is complete, you can update your local `kubeconfig` to interact with your new cluster.
    ```bash
    gcloud container clusters get-credentials $(terraform output -raw gke_cluster_name) --region $(terraform output -raw gke_cluster_region)
    ```

5.  **Destroy the infrastructure:**
    ```bash
    terraform destroy -var="gcp_project_id=your-gcp-project-id"
    ```
    This will tear down all resources created by Terraform. Enter `yes` when prompted to confirm.