# Helm Example

This repo contains a sample Helm chart demonstrating how to deploy a Postgres database and a Spring application together in Kubernetes. It uses templates for configuration, allows customizing via `values.yaml`, and includes environment setup for both “in-cluster” Postgres and a Spring app.

---

## 🗂 Structure

```

helm-example/
└── helm/
├── Chart.yaml
├── values.yaml
├── templates/
│   ├── deployment-postgres.yaml
│   ├── service-postgres.yaml
│   ├── deployment-springapp.yaml
│   ├── service-springapp.yaml
│   ├── configmap-spring.yaml
│   ├── secret-postgres.yaml
│   └── ... (other templated resources)
└── charts/
````


- `Chart.yaml` – Metadata about the Helm chart (name, version, etc.).  
- `values.yaml` – Default configuration values (Postgres image, Spring app image, ports, replicas, etc.).  
- `templates/` – Templated Kubernetes YAMLs (Deployments, Services, ConfigMaps, Secrets, etc.), which are rendered based on `values.yaml` or user overrides.  
- `charts/` – Place for any dependent subcharts (if added).

---

## ✅ What it does

- Deploys **Postgres** with parameters defined in `values.yaml`:
  - image, username, password, database name, port, timezone, replicas  
- Deploys **Spring Boot application** connecting to Postgres:
  - Uses `springApp.image`, port, replicas etc. from `values.yaml`  
- Provides template for ConfigMap / Secret so you can externalize configuration (DB credentials, URL etc.)  
- Allows customizing the deployment via Helm parameters / overrides  

---

## 🛠 Prerequisites

- A Kubernetes cluster (local or cloud)  
- Helm installed (v3+)  
- `kubectl` access to your cluster  

---

## 🚀 How to run

1. Clone this repository:

```bash
   git clone https://github.com/gokul656/helm-example.git
   cd helm-example/helm
```

2. (Optional) Review / edit `values.yaml` to change defaults, e.g.:

   ```yaml
   postgres:
     image: postgres:16
     user: myuser
     password: mypassword
     database: mydb
     port: 5432
     timezone: UTC
     replicas: 1

   springApp:
     image: malware656/spring-app-pg:latest
     port: 8080
     replicas: 2
   ```

3. Install the Helm chart:

   ```bash
   helm install spring-stack ./
   ```

   Replace `spring-stack` with a name you prefer.

4. Verify the deployment:

   ```bash
   kubectl get pods
   kubectl get svc
   ```

5. To override values, you can use:

   ```bash
   helm install my-release ./ -f custom-values.yaml
   ```

   or

   ```bash
   helm install my-release ./ --set springApp.replicas=3 --set postgres.password=newpassword
   ```

---

