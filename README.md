# aws-lambda-go

Create an S3 bucket (remove lines after the comment in template.yaml)
`aws cloudformation deploy --template-file template.yaml --stack-name GolangLambda`

Build go source 
`env GOOS=linux GOARCH=amd64 go build .`

and zip it, then upload it to S3 bucket

`aws s3api put-object --body aws-lambda-go.zip --bucket go-lambda-lc-20191211 --key aws-lambda-go.zip`

Re-deploy the first stack after having uploaded the zip.

`aws cloudformation deploy --template-file template.yaml --stack-name GolangLambda --capabilities CAPABILITY_NAMED_IAM`

Invoke the newly created lambda:

`aws lambda invoke --function-name lambda-go-function --payload '{ "name": "Bob" }' response.json`


TBD

- how to update lambda after a new S3 upload
- delete custom object names to prevent errors when relaunching commands