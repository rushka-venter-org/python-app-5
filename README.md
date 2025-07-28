# How to setup kubernetes cluster

## Deleting previous kubernetes
```
kind delete cluster --name kind
```

## Installing kind
```
winget install Kubernetes.kind
```

```
kind create cluster --config kind-config.yaml
```

## Install ingress-nginx
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

## Install Helm
```
winget install Helm.Helm
```

## Installing argocd
```
helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace -f values-argo.yaml
```
Get password
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }

```

## Installing the self-hosted-runner
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml
```

```
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller

helm upgrade --install --namespace actions-runner-system --create-namespace\
  --set=authSecret.create=true\
  --set=authSecret.github_token="REPLACE_YOUR_TOKEN_HERE"\
  --wait actions-runner-controller actions-runner-controller/actions-runner-controller

kubectl apply -f runnerdeployment.yaml -n actions-runner-system
```

## Install ArgoCLI
```
$url = "https://github.com/argoproj/argo-cd/releases/download/" + $version + "/argocd-windows-amd64.exe"
$output = "argocd.exe"

Invoke-WebRequest -Uri $url -OutFile $output

[Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\Path\To\ArgoCD-CLI", "User")
```

```
$env:ARGOCD_SERVER = "https://argocd.test.com"
```

```
argocd login argocd.test.com --insecure --grpc-web --username admin --password <password>
```

# Backstage
We need to build it on a container/machine with node
```
docker pull node:18-bookworm-slim
```





```
docker run --rm -e AUTH_GITHUB_CLIENT_ID=Ov23lidL0O5JNlKOM7Rg -e AUTH_GITHUB_CLIENT_SECRET=secret -e GITHUB_TOKEN=token -p 3000:3000 -ti -p 7007:7007 -v /home/rushkaventer/backstage-app:/app -w /app node:18-bookworm-slim bash
```