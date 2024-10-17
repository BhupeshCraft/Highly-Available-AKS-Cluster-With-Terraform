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

## Initialize and Apply :-

<br>

` terraform init ` <br>

` terraform apply ` <br>

<br>

## Best Practices (Production Considerations) :-

<br>

<h4 align="center"> 1) Private Cluster :- </h4>

<br>

<b> A private cluster ensures that your Kubernetes API server is only accessible via private IPs, enhancing the security of your cluster by restricting public internet access. It means only specific IPs, such as those from a VPN or internal network, can access the cluster. <b> <br>

<br>

<a href="aks-prod-cluster/Best Practices/private-cluster.tf"> • Source Code </a> <br>

<br>

<h4 align="center"> 2) Multiple Node Pools :- </h4>

<br>

<b> Multiple node pools allow you to separate workloads across different nodes, enabling better management and scaling of different types of workloads (e.g., system workloads, user workloads, spot instances for cost savings). </b>

<br>

<a href="aks-prod-cluster/Best Practices/multiple-node-pools.tf"> • Source Code </a> <br>

<br>

<h4 align="center"> 3) Managed Identity :- </h4>

<br>

<b> Managed identities for Azure resources provide Azure services with an automatically managed identity in Azure AD, which you can use to authenticate to any service that supports Azure AD authentication without having to manage credentials. </b>

<br>

<a href="aks-prod-cluster/Best Practices/managed-identity.tf"> • Source Code </a> <br>

<br>

<h4 align="center"> 4) Use Auto-Scaling :- </h4>

<br>

<b> Auto-scaling automatically adjusts the number of nodes in your node pools based on the demand, ensuring your applications can handle load spikes and save costs when the demand is low. </b>

<br>

<a href="aks-prod-cluster/Best Practices/use-auto-scaling.tf"> • Source Code </a> <br>

<br>

<h2 align="center"> 3) Implement Production-Grade Observability : </h2>

<br>

## Install Prometheus and Grafana using Helm :-

<br>

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

<br>

## Deploy Prometheus and Grafana for monitoring and visualization :-

<br>

` helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace `

<br>

## Set up Grafana for advanced dashboards :-

<br>

` helm install grafana grafana/grafana --namespace monitoring `

<br>

## Logging with Grafana Loki :-

<br>

helm install loki grafana/loki-stack --namespace logging --create-namespace

<br>

` helm install loki grafana/loki-stack --namespace logging --create-namespace `

<br>

## Pixie for Advanced Observability (Use Pixie to gain granular insights into your application with minimal overhead. Pixie can automatically trace and visualize all interactions) :-

<br>

` px deploy `

<br>

## OpenTelemetry (OTEL) (For tracing, use OTEL to capture and analyze application traces) :-

<br>

` helm install otel-collector open-telemetry/opentelemetry-collector --namespace observability --create-namespace `

<br>

<b> Note : Configure OTEL to export traces and metrics to Grafana for visualization. <b>

<br>

<h2 align="center"> 4) Set Up Advanced Security Policies with Kyverno : </h2>

<br>

## Install Kyverno :-

<br>

` helm install kyverno kyverno/kyverno --namespace kyverno --create-namespace `

<br>










