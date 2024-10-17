<h1 align="center"> Highly Available AKS Cluster With Terraform ☸🏗️ </h1>

<br>

<h2 align="center"> Pre-Requisite : </h2>

<br>

<b> • VS Code : Your intuitive code editor. </b> <br>
<b> • Git : Reliable version control for your code </b> <br>
<b> • GitHub : Collaborative code repository </b> <br>
<b> • Azure Subscription : Create one if you don’t have it. </b> <br>
<b> • Terraform : Install Terraform (v1.3 or higher recommended). </b> <br>
<b> • Azure CLI : Install the Azure CLI. </b> <br>
<b> • Helm : Install Helm for managing Kubernetes charts. </b> <br>
<b> • kubectl : Kubernetes CLI to manage your AKS cluster. </b> <br>
<b> • Prometheus : For monitoring. </b> <br>
<b> • Grafana : For visualization. </b> <br>
<b> • Grafana Loki : For logging. </b> <br>
<b> • Kyverno : To manage security policies in Kubernetes. </b> <br>
<b> • Pixie : For advanced observability. </b> <br>
<b> • OpenTelemetry (OTEL) : For traces and metrics. </b> <br>

<br>

<h2 align="center"> 1) Configure Azure CLI :- </h2>

<br>

` az login  ` <br>
` az account set --subscription "your-subscription-id" `

<br>

<h2 align="center"> Setup Terraform & Azure Authentication :- </h2>

<br>

` az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your-subscription-id>" `

<br>

Store the `client_id` , `client_secret` , `tenant_id` , and `subscription_id` for later use in your Terraform configuration.

<br>

<h2 align="center"> 2) Define Terraform Configuration : </h2>

<br>

## Create a new directory for your project :-

<br>

```
mkdir aks-terraform-project
cd aks-terraform-project
```

<br>

## Define Infrastructure Resources in Terraform As Per Following :-

<br>

<b> • AKS with multiple node pools for high availability and scalability. </b> <br>
<b> • Azure Load Balancer with a standard SKU for production use. </b> <br>
<b> • Managed Identities for secure access to Azure services. </b> <br>
<b> • Private Cluster with restricted access and VNET integration for security. </b> <br>

<br>

<a href="aks-prod-cluster/infra/main.tf"> • main.tf </a> <br>
<a href="aks-prod-cluster/infra/variables.tf"> • variables.tf </a> <br>
<a href="aks-prod-cluster/infra/terraform.tfvars.tf"> • terraform.tfvars </a> <br>

<br>

<h3 align="center"> Note : Set Up Variables in "variables.tf"  and "terraform.tfvars" for flexibility. </h3>

<br>

### Initialize and Apply :-

<br>

` terraform init ` <br>

` terraform apply ` <br>

<br>

### Some Best Practices :-

<br>




