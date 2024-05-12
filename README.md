# MicroK8s and ArgoCD Deployment Guide

## Prerequisites

- [MicroK8s](https://microk8s.io/) installed and running on your system.
- [Docker](https://www.docker.com/) installed on your system.
- [ArgoCD](https://argoproj.github.io/argo-cd/) installed in MicroK8s.

## Steps

1. **Create a GitHub Repository:**
   - Create a new repository on GitHub and clone it to your local machine.
     ```bash
     git clone <repository_url>
     ```

2. **Add Node.js App Code:**
   - Clone the Node.js "Hello World" application repository:
     ```bash
     git clone https://github.com/johnpapa/node-hello.git
     ```
   - Add the code to your personal repository.

3. **Set Up GitHub Workflow:**
   - Configure a GitHub Actions workflow for continuous build and push of the Docker image to Docker Hub. Detailed instructions can be found in `.github/workflows/README.md`.

4. **Create Helm Chart:**
   - Create a Helm chart for deployment.
     ```bash
     helm create <chart_name>
     ```
   - Update the `values.yaml` file according to your requirements.

     Example `values.yaml`:
     ```yaml
     replicaCount: 1

     image:
       repository: vijatykumar1/react
       pullPolicy: IfNotPresent
       tag: "" # Leave empty for GitHub Actions to generate dynamically

     service:
       type: ClusterIP
       port: 3000
       targetport: 3000
     ```

5. **Update Helm Chart Automatically:**
   - Update the Docker image tag in the Helm chart dynamically using GitHub Actions.
     ```bash
     sed -i "s/tag:.*/tag: $DOCKER_TAG/" helm/<chart_name>/values.yaml
     git add helm/<chart_name>/values.yaml
     git commit -m "Update image tag in Helm chart"
     git push
     ```

6. **Deploy with ArgoCD:**
   - Create an ArgoCD application manifest file stored in the `argocd` folder of the Git repository.
   - Deploy the ArgoCD application manifest to sync the Git repository and deploy it into Kubernetes.
   - Alternatively, login to the ArgoCD server and manually create the application by providing the app name, Git repository URL, branch, path towards the Helm chart, cluster URL, and configure automatic sync process. ArgoCD will detect changes in the Helm chart repository and automatically deploy the updated image to Kubernetes.

By following these steps, you can automate the deployment of your Node.js application using MicroK8s, Docker, GitHub Actions, Helm, and ArgoCD.