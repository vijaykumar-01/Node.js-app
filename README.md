# Node.js Application Deployment with MicroK8s and ArgoCD

## Prerequisites

- MicroK8s installed and running on your system (Alternatively, you can use Minikube or any other Kubernetes platform).
- Docker installed on your system.
- ArgoCD installed in MicroK8s.
- Node.js application code.

## Steps

1. **Clone the Repository:**
   - Create a new repository on GitHub and clone it to your local machine.
     ```bash
     git clone <repo_url>
     ```
   - Add the necessary code from the provided repository:
     Repository URL: [https://github.com/johnpapa/node-hello.git](https://github.com/johnpapa/node-hello.git)

2. **Setup GitHub Workflow:**
   - Configure GitHub Actions workflow for continuous build and push of the Docker image to Docker Hub. Detailed instructions are provided in `.github/workflows/Readme.md`.

3. **Create Helm Chart:**
   - Create a Helm chart for the deployment through ArgoCD.
     ```bash
     helm create <chart_name>
     ```
   - Update the `values.yaml` file according to your requirements. Example:
     ```yaml
     replicaCount: 1

     image:
       repository: vijatykumar1/node-app
       pullPolicy: IfNotPresent
       tag: ""
     
     service:
       type: ClusterIP
       port: 3000
       targetport: 3000
     ```
   - Leave the `tag` field empty to dynamically update it during the GitHub Actions workflow.

4. **Update Helm Chart Values:**
   - Update the tag name using the `sed` command in the GitHub Actions workflow. Example:
     ```bash
     sed -i "s/tag:.*/tag: $DOCKER_TAG/" helm/node/values.yaml
     git config --global user.email "iamvijaykumar.a@gmail.com"
     git config --global user.name "vijaykumar-01"
     git add helm/node/values.yaml
     git commit -m "Update image tag in Helm chart"
     git push
     ```

5. **Deploy with ArgoCD:**
   - Configure ArgoCD with the repository URL and provide the path to the Helm chart.
   - Specify the cluster URL and select automatic sync to detect changes in the Helm chart.
   - Alternatively, deploy the ArgoCD application manifest file stored in the `argocd` folder of the Git repository.

6. **Verify Deployment:**
   - Use the following commands to verify the deployment:
     ```bash
     kubectl get pods -n <namespace>   # Example: kubectl get pods -n dev
     kubectl get svc
     ```
   - Use port forwarding for local access if no ingress or load balancer is set up:
     ```bash
     kubectl port-forward svc/nodejs-app -n <namespace> 3001:3000
     ```

Ensure that the provided steps are followed carefully to deploy the Node.js application with MicroK8s and ArgoCD successfully. For any assistance or troubleshooting, refer to the documentation or seek help from the repository owner.
