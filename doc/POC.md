# Accessing ArgoCD on a Minikube Cluster

## 1. Install Minikube

If you haven't installed Minikube yet, follow the installation instructions for your operating system from the [official Minikube documentation](https://minikube.sigs.k8s.io/docs/start/).

## 2. Start Minikube

Start your Minikube cluster:

```bash
minikube start

3. Install ArgoCD
Step 1: Create the argocd Namespace

bash

kubectl create namespace argocd

Step 2: Apply the ArgoCD Installation Manifests

bash

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

4. Access the ArgoCD API Server
Step 1: Port-Forward the ArgoCD API Server

bash

kubectl port-forward svc/argocd-server -n argocd 8080:443

This command will forward the ArgoCD API server to localhost:8080.
Step 2: Open the ArgoCD UI

Open your web browser and go to:

arduino

https://localhost:8080

Step 3: Login to ArgoCD

By default, the username is admin. To retrieve the initial password, you need to get the password from the ArgoCD secret:

bash

kubectl get pods -n argocd
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml

Decode the password from the secret:

bash

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode; echo

Use the username admin and the retrieved password to log in to the ArgoCD UI.

This setup should help you install and access ArgoCD on a Minikube cluster.