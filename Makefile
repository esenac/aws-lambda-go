build: 
	docker build -t esenac/aws-lambda-go .

compile: 
	docker run -e GOOS=linux -e GOARCH=amd64 -v $$(pwd):/app -w /app golang:1.13 go build -ldflags="-s -w" -o bin/aws-lambda-go

plan: compile
	docker run -v $$(pwd)/main.tf:/srv/main.tf -v $$(pwd)/terraform.tfstate:/srv/terraform.tfstate -v $$(pwd)/bin:/srv/bin -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$$AWS_DEFAULT_REGION esenac/terraform-aws plan

apply: compile
	docker run -v $$(pwd)/main.tf:/srv/main.tf -v $$(pwd)/terraform.tfstate:/srv/terraform.tfstate -v $$(pwd)/bin:/srv/bin -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$$AWS_DEFAULT_REGION esenac/terraform-aws apply -auto-approve

destroy:
	docker run -v $$(pwd)/main.tf:/srv/main.tf -v $$(pwd)/terraform.tfstate:/srv/terraform.tfstate -v $$(pwd)/bin:/srv/bin -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$$AWS_DEFAULT_REGION esenac/terraform-aws destroy -auto-approve