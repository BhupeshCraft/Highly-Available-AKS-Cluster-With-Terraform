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

## Best Practices With Kyverno Policies (Production Considerations) :-

<br>

<h4 align="center"> 1) Disallow Privileged Containers :- </h4>

<br>

<a href="aks-prod-cluster/kyverno-policies/disallow-privileged-containers.yaml"> • Source Code </a> <br>

<br>

<b> Prevent pods from running with privileged access, a common security best practice. </b>

<br>

<h4 align="center"> 2) Enforce Resource Limits :- </h4>

<br>

<b> Ensure all containers have defined CPU and memory limits to avoid resource contention and cluster instability. </b>

<br>

<a href="aks-prod-cluster/kyverno-policies/require-resource-limits.yaml"> • Source Code </a> <br>

<br>

<h4 align="center"> 3) Mandatory Image Registries :- </h4>

<br>

<b> Restrict containers to use only approved image registries (e.g., from Azure Container Registry or Docker Hub) </b>

<br>

<a href="aks-prod-cluster/kyverno-policies/allow-image-registries.yaml"> • Source Code </a> <br>

<br>

<h4 align="center"> 4) Enforce Read-Only Root Filesystem :- </h4>

<br>

<b> Ensure all containers are set to use a read-only root filesystem, limiting the possibility of compromising the underlying host. </b>

<br>

<a href="aks-prod-cluster/kyverno-policies/require-read-only-root-filesystem.yaml"> • Source Code </a> <br>

<br>

## Apply the Policies :-

<br>

` kubectl apply -f disallow-privileged.yaml ` <br>
` kubectl apply -f require-resource-limits.yaml ` <br>
` kubectl apply -f allowed-image-registries.yaml ` <br>
` kubectl apply -f require-read-only-root-filesystem.yaml ` <br>

<br>

<b> NOTE : These policies are designed to maintain a high level of security, enforce compliance, and reduce vulnerabilities in production environments. </b>

<br>

<h2 align="center"> 5) Best Practices and Scaling : </h2>

<br>

<h4 align="center"> i) High Availability and Scalability :- </h4>

<br>

<b> Horizontal Pod Autoscaling (HPA): Use HPA to dynamically adjust the number of pod replicas in response to traffic. </b>

<br>

<b> Cluster Autoscaler: Automatically add/remove nodes from the AKS cluster based on workload demand.

<br>

<a href="aks-prod-cluster/Best Practices and Scaling/enable-autoscaling.tf"> • Source Code </a> <br>

<br>

<h4 align="center"> ii) Network Policies :- </h4>

<br>

<b> Implement network policies to control the traffic between pods and ensure that only necessary communication is allowed. For example, you can restrict communication between namespaces or deny all traffic by default and allow only specific communications. </b>

<br>

<a href="aks-prod-cluster/Best Practices and Scaling/network-policies.yaml"> • Source Code </a> <br>

<br>

<h2 align="center"> 6) Backup and Disaster Recovery : </h2>

<br>

<b> To enable Azure Backup for your AKS cluster and its resources (such as persistent volumes), you can use Azure Backup for AKS to protect critical data and configurations. Azure Backup provides automated and manual backup for Azure resources, including Azure Disk snapshots and AKS cluster state backups. </b>

<br>

## Enable Azure Kubernetes Service (AKS) Backup using Azure CLI :-

<br>

<h4 align="center"> I) Install the Azure CLI Backup Extension :- </h4>

<br>

` az extension add --name dataprotect `

<br>

<h4 align="center"> II) Create a Recovery Services Vault (A Recovery Services Vault is necessary to store the backups. Create one in the same resource group and region as your AKS cluster) :- </h4>

<br>

` az backup vault create --resource-group <your-resource-group> --name <your-vault-name> --location <region> `

<br>

<h4 align="center"> III) Assign Backup Permissions to AKS Cluster (The AKS cluster must have the necessary permissions to create and manage backups. Assign a Managed Identity with Contributor role) :- </h4>

<br>

` az aks update --resource-group <your-resource-group> --name <your-aks-cluster> --assign-identity <identity-id> `

<br>

<b> NOTE : Or you can assign a Contributor role using an existing service principal if you're using Azure AD integration. </b>

<br>

<h4 align="center"> IV) Enable Backup for AKS Cluster :- </h4>

<br>

` az backup protection enable-for-vm --vault-name <your-vault-name> --resource-group <your-resource-group> --vm <your-aks-cluster> `

<br>

<h4 align="center"> V) Set a Backup Policy (Define a backup policy to control the frequency and retention of backups) :- </h4>

<br>

` az backup policy create --vault-name <your-vault-name> --name <policy-name> --policy <policy-parameters.json> `

<br>

<b> Here’s an example of a basic policy JSON :- </b>

<br>

```
{
    "name": "aks-backup-policy",
    "properties": {
        "schedulePolicy": {
            "scheduleRunFrequency": "Daily",
            "scheduleRunTimes": ["2024-10-17T02:00:00Z"]
        },
        "retentionPolicy": {
            "retentionDuration": {
                "count": 30,
                "durationType": "Days"
            }
        }
    }
}
```

<br>

<b> NOTE : You can adjust this policy based on your requirements (e.g., daily backups and 30-day retention) </b>

<br>

<h4 align="center"> VI) Enable Backup for Persistent Volumes (To enable backups for persistent volumes (PV) in your AKS cluster, you’ll first need to ensure that the volumes are using Azure Managed Disks) </h4>

<br>

` az backup protection enable-for-disk --vault-name <your-vault-name> --resource-group <your-resource-group> --disk <disk-name> `

<br>

<b> NOTE : This command allows you to enable protection for any managed disk used in the cluster, including those attached to your persistent volumes. </b>

<br>

## Enable Automatic Backup for Persistent Volumes using Velero :-

<br>

<b> For a more Kubernetes-native approach, you can use Velero (an open-source backup and recovery tool) along with Azure Blob storage for persistent volume backup. </b>

<br>

<h4 align="center"> I) Install Velero :- </h4>

<br>

```
velero install \
    --provider azure \
    --plugins velero/velero-plugin-for-microsoft-azure:v1.4.0 \
    --bucket <your-blob-container> \
    --secret-file ./credentials-velero \
    --backup-location-config resourceGroup=<your-blob-resource-group>,storageAccount=<your-storage-account>,subscriptionId=<your-subscription-id>
```

<br>

<b> NOTE : Replace the placeholder values with your Azure Blob storage and resource group. </b>

<br>

<h2 align="center"> II) Create a Backup Schedule :- </h2>

<br>

` velero schedule create daily-backup --schedule "0 2 * * *" `

<br>

<b> This example creates a daily backup at 2 AM for your persistent volumes. </b>

<br>

## Monitor and Manage Backups :-

<br>

<b> NOTE : You can monitor your backup jobs using the Azure Portal or Azure CLI </b>

<br>

` az backup job list --vault-name <your-vault-name> --resource-group <your-resource-group> `

<br>

<b> NOTE : To restore a backup (whether it's the cluster state or persistent volumes). </b>

<br>

` az backup restore restore-disks --vault-name <your-vault-name> --resource-group <your-resource-group> --restore-request <restore-request> `

<br>

<h2 align="center"> THANK YOU 🙏🏻 </h2>

<br>







