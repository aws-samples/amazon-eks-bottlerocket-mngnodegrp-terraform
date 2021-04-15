## Setup Bottlerocket Managed Node Group on EKS with Terraform

By default, instances in a managed node group use the latest version of the Amazon EKS optimized Amazon Linux 2 AMI for its cluster. You can choose between standard and GPU variants of the Amazon EKS optimized Amazon Linux 2 AMI. At this point, *Bottlerocket* is not natively supported as a built-in OS choice for managed node groups though, in the future, it will be. Until then, this repo and terraform scripts should provide a reliable set of steps to build a managed node group with Bottlerocket nodes using [launch templates](https://docs.aws.amazon.com/autoscaling/ec2/userguide/LaunchTemplates.html). 

## Prerequisites

* An AWS account with admin privileges - We will assume you already have an [AWS account](https://docs.aws.amazon.com/polly/latest/dg/setting-up.html) with admin privileges.
* Command-line tools - Mac/Linux users need to install the latest version of [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html),[kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html), and [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (>=v0.13.0) on their workstation.Whereas Windows users need to create an EC2 [Cloud9 environment](https://docs.aws.amazon.com/cloud9/latest/user-guide/create-environment-main.html) in AWS and then install these CLI's inside their Cloud9 environment.

## Architecture
![image](https://user-images.githubusercontent.com/80008225/114781741-b1b69c00-9d3e-11eb-8db4-3c7961f48526.png)


## Usage Example 

* Clone terraform codes in your home directory 
```
git clone  https://github.com/aws-samples/amazon-eks-bottlerocket-mngnodegrp-terraform.git
```
* Change directory to amazon-eks-bottlerocket-mngnodegrp-terraform
```
cd amazon-eks-bottlerocket-mngnodegrp-terraform
```
* Then run init, plan and apply commands.
```
terraform init
```
```
terraform plan
```
```
terraform apply --auto-approve
```


## License

This library is licensed under the MIT-0 License. See the LICENSE file.
