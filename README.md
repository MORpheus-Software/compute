
# Compute Deployment

This repository automates the creation of a GPU enabled cluster in GCP, and then uses Helm to automate the deployment of an Ollama instance configured to run Llama2 on startup. It also sets up a proxy router to expose the Ollama service to Morpheus. It exposes the proxy router service on port 3333

## Requirements

Before beginning, ensure you have the following:

1. **Wallet Private Key**: A private key for a wallet funded with ETH and MOR tokens.
2. **Terraform CLI**: Installed to manage infrastructure as code.
    - used to create the cluster and deploy the necessary resources
3. **gcloud CLI**: Installed with the Kubernetes authentication plugin enabled.
    - used to talk to the cluster after deployment
4. **google service account credentials**: For provisioning cluster resources
    - this account must have google kubernetes engine and compute engine access

## Deployment Steps

Follow these steps to deploy the Ollama and Proxy Router setup:

1. **Set Environment Variables**: Configure necessary variables for your deployment.
    - this will be different depending on if you use local state, remote state, or terraform cloud.
2. **Initialize Terraform**:
   ```bash
   terraform init
   ```
3. **Plan the Infrastructure**:
   ```bash
   terraform plan
   ```
4. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
5. **Retrieve Kubernetes Endpoint IP**: After deployment, get the external IP of the proxy-router service endpoint.

## Registration Steps

> *In future updates, these steps may be automated.*

1. **Connect to cluster via kubernetes**
    - gcloud container clusters get-credentials mln-cluster --region us-west1

2. **Expose the Proxy Service**:
   - Forward port 8082 of the proxy service:
     ```bash
     kubectl port-forward svc/proxy-router 8082:8082
     ```
3. **Verify router is working**
    - check kubectl logs
    - verify swagger api http://localhost:8082/swagger/index.html

4. **Authorize diamond contract to act on behalf of wallet**:
    - todo

5. **Allowance?**
    - todo

6. **Register Provider**:
   - Use the following command to register the provider:

7. **Register Model**:
   - Register the Llama2 model:

8. **Place a Bid**:
   - Submit a bid:

9. **Test functionality**
    - todo

## TODO:
 - Trigger on Pull request and Merge
 - Setup a second environment for mainnet
 - DNS?
 - create a seperate charts repo to seperate charts from cluster
 - seperate proxy from llm deployment
 - better model config mounting and registration process
 - more securely capture, store, and use secrets
 - tidy up values.yaml and expose more attributes to allow greater control
 - create seperate repo for building/publishing router docker image.
