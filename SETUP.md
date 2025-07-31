# Technical Evaluation Initial Setup

To start working on the solution, I wanted to set up and EKS cluster to run the works loads on as if it were a customer cluster. I created the `eks_environment` folder to house all of my Terraform code to be able to update things programatically for the set up. 

I am using the [EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) and [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) to create a small EKS cluster in `us-east-1` with [Karpenter](https://karpenter.sh/) to manage any scaling operations.

## Pre-reqs

- [Terraform](https://developer.hashicorp.com/terraform/install) or [Tofu](https://opentofu.org/docs/intro/install/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Helm](https://helm.sh/docs/intro/install/)
- [Kubectl](https://kubernetes.io/releases/download/)

## Creating the Cluster

1. Clone down the repo

    ```bash
    git clone https://github.com/b1tsized/Wallarm-Solutions-Engineer-Challenge.git
    ```

2. `cd` into the eks_environment directory.

    ```bash
    cd ./Wallarm-Solutions-Engineer-Challenge/eks_environment
    ```

3. Create a `terraform.tfvars` file and set the `profile` varibale to the correct AWS profile you'd like to use.

    ```tf
    profile = "prod"
    ```

4. Now you can initialize this either with `terraform` or `tofu`
    
    Terraform:
    ```bash
    terraform init
    ```
    Tofu:
    ```bash
    tofu init
    ```

5. Run a plan to validate that all changes are being made correctly.

    Terraform:
    ```bash
    terraform plan
    ```
    Tofu:
    ```bash
    tofu plan
    ```

6. Once you've ensured that this will create a new VPC, EKS Cluster, and run a Helm release for Karpenter you can apply.

    Terraform:
    ```bash
    terraform apply
    ```
    Tofu:
    ```bash
    tofu apply
    ```

7. Accept any changes by typing `yes`.

8. Once it has successfully run you should be able to update you `kubeconfig` by running the following:

    ```bash
    aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME
    ```

9. Validate you're able to see all the pods running on the nodes.

    ```bash
    kubectl get pods -A
    ```

10. You should note there is an `httpbin` pod in namespace `wallarm`. Forward traffic locally by using the following command.

    ```bash
    kubectl port-forward deployment/httpbin 8080:8080 -n wallarm
    ```

11. In another terminal window, you can run curl commands to validate it's forwarding traffic internally only.

    ```bash
    curl -I localhost:8080/status/403
    ```

12. That should return a `403` status code.