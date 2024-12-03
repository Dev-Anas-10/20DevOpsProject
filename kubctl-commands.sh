#!/bin/bash

# Get all resources in the current namespace
kubectl get all # List all resources in the current namespace, such as Pods, Services, etc.

# Get all resources in a specific namespace
kubectl get all -n <namespace> # Replace <namespace> with the desired namespace name.

# Create or update resources from a YAML/JSON file
kubectl apply -f <file-name> # Apply changes or create resources defined in a file.

# Delete resources defined in a YAML/JSON file
kubectl delete -f <file-name> # Delete resources based on the file content.

# Get all Pods in the current namespace
kubectl get pods # Display a list of all running Pods.

# Describe a specific Pod
kubectl describe pod <pod-name> # Show detailed information about a specific Pod.

# Access a Pod's terminal
kubectl exec -it <pod-name> -- /bin/bash # Start an interactive Bash shell in the specified Pod.

# View logs of a specific Pod
kubectl logs <pod-name> # Display logs of a container in the Pod.

# Delete a specific Pod
kubectl delete pod <pod-name> # Terminate and remove the specified Pod.

# Get all Deployments
kubectl get deployments # List all Deployments in the current namespace.

# Describe a specific Deployment
kubectl describe deployment <deployment-name> # Show detailed information about a Deployment.

# Scale a Deployment (increase/decrease the number of Pods)
kubectl scale deployment <deployment-name> --replicas=<number> # Adjust the number of replicas.

# Delete a specific Deployment
kubectl delete deployment <deployment-name> # Remove the specified Deployment.

# Get all Services
kubectl get services # List all Services in the current namespace.

# Describe a specific Service
kubectl describe service <service-name> # Show detailed information about a Service.

# Delete a specific Service
kubectl delete service <service-name> # Remove the specified Service.

# List all Namespaces
kubectl get namespaces # Show all available namespaces.

# Create a new Namespace
kubectl create namespace <namespace-name> # Replace <namespace-name> with your desired name.

# Delete a Namespace
kubectl delete namespace <namespace-name> # Remove the specified namespace and all its resources.

# Display cluster information
kubectl cluster-info # Show information about the Kubernetes cluster.

# Show events in the current namespace
kubectl get events # Display a list of events, useful for debugging.

# Check the status of Kubernetes components
kubectl get componentstatuses # Verify the status of the control plane components.

# View kubeconfig settings
kubectl config view # Display the current kubeconfig settings.

# Switch to a specific Kubernetes context
kubectl config use-context <context-name> # Change the context to another cluster or user.

# Show the current Kubernetes context
kubectl config current-context # Display the active context.

# Apply resources from a remote URL
kubectl apply -f https://<url-to-file>.yaml # Create resources directly from a YAML file hosted online.

# Delete all Pods in a specific Namespace
kubectl delete pods --all -n <namespace> # Remove all Pods in the specified namespace.

kubectl apply -f <directory-path>

kubectl delete -f <directory-path>

# info abot ingress ELB in AWS
https://github.com/kubernetes/ingress-nginx/blob/main/docs/deploy/index.md
sed -i 's|proxy-real-ip-cidr:.*|proxy-real-ip-cidr: ${{ env.CIDR }}|' deploy.yaml
sed -i 's|arn:aws:acm:us-west-2:.*|${{ env.CERT_ARN }}|' deploy.yaml

# ingress ELB in Local VM search metallb
