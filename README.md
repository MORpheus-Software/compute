
# Compute Deployment

This repository automates the creation of a GPU enabled cluster in GCP, and then uses Helm to automate the deployment of an Ollama instance configured to run Llama2 on startup. It also sets up a proxy router to expose the Ollama service to Morpheus. It exposes the proxy router service on port 3333

## Requirements

Before beginning, ensure you have the following:

1. **Wallet Private Key**: A private key for a wallet funded with ETH and MOR tokens.
2. **Terraform CLI**: Installed to manage infrastructure as code.
    - used to create the cluster and deploy the necessary resources
3. **gcloud CLI**: Installed with the Kubernetes authentication plugin enabled.
    - used to talk to the cluster after deployment
4. **kubernetes cli**
    - install kubernetes cli
        - google sdk:
            - gcloud components install kubectl
        - ubuntu snap:
            - sudo snap install kubectl --classic
        - mac brew:
            - brew install kubectl
4. **google service account credentials file saved**: For provisioning cluster resources
    - this account must have google kubernetes engine and compute engine access
        steps to get google creds: (TODO: provide cli commands)
        - create service account
        - delegate service account access to compuute engine, container engine
        - download credentialfile.json and place in terraform folder

## Deployment Steps

Follow these steps to deploy the Ollama and Proxy Router setup:


export google creds:
    - export GOOGLE_APPLICATION_CREDENTIALS=google-credentials.json; 

1. rename terraform.tfvars.example to terraform.tfvars
2. update the values in tfvars

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```
4. **Plan the Infrastructure**:
   ```bash
   terraform plan
   ```
5. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
6. **Retrieve Kubernetes Endpoint IP**: After deployment, get the external IP of the proxy-router service endpoint.

## Registration Steps

1. **get kubernetes credentials for cluster**
    - gcloud container clusters get-credentials mln-cluster --region us-west1

2. **verify kubernetes deployment**
    - Check pods are running
        - `kubectl get pod`
            - should see 2 pods, proxy-router and ollama, both with status of running
    - Check logs of proxy router
        `kubectl logs [proxy-router-pod-name-here]`
            - last few logs should say 'listening for events from diamond'

3. **Expose the Proxy Service**:
   - Forward port 8082 of the proxy service:
     ```bash
     kubectl port-forward svc/proxy-router-internal 8082:8082
     ```
4. **Verify router is working**
    - check kubectl logs
    - verify swagger api http://localhost:8082/swagger/index.html

4. **Authorize diamond contract to act on behalf of wallet**:
    - todo
    - confirm using et

6. **Register Provider**:
   - Use the following command to register the provider:
   - confirm using get

7. **Register Model**: THIS IS OPTIONAL, ONLY REQUIRED IF YOURE NOT HOSTING A MODEL THAT ALREADY EXISTS AS AN OPTION ON CHAIN ALREADY
   - Register the Llama2 model:
   - generate model using this bash script:
        - 
   - confirm using get

8. **Place a Bid**:
   - Submit a bid:
   - confirm using get

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
 - add docker compose files and instructions somewhere for local implementations
