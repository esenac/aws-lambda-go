package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

type helloEvent struct {
	Name string `json:"name"`
}

func handleRequest(ctx context.Context, name helloEvent) (string, error) {
	return fmt.Sprintf("Hello %s!", name.Name), nil
}

func main() {
	lambda.Start(handleRequest)
}
