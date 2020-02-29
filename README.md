# aws-lambda-go

Sample project to deploy an AWS Lambda function in Go using Terraform.

## How to

### Overview 

Commands are defined in `Makefile` and allow to perform Terraform commands in a Docker image, installing the required providers once. This is acheived by mounting files in the docker instead of the whole project folder, preventing to override `providers.tf` file (it's used in Dockerfile to install Terraform plugins).

### Build Docker image

You have to build the Docker image containing Terraform and the required providers, so that you don't have to download Terraform binary to your machine.
Anyway, this step is not required if you pull the latest image from dockerhub.


### Compile source code

In order to compile your source code, run `make compile`. This command executes `go build` command in a Go docker, so that you don't have to install Go on your machine.

_Note: this step isn't mandatory for `plan` and `apply` commands, since it's automatically executed._

### Terraform commands

Terraform `plan`, `apply` and `destroy` commands are available on the corresponding `make` commands. 

## TODO

We still have to handle remote state, that's why `terraform.tfstate` is mounted in the Docker.