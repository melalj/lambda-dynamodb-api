# Lambda DynamoDB API

API gateway for DynamoDB using AWS Lambda

Inspiration from: [Build a serverless URL shortener with AWS Lambda and API Gateway services](http://www.davekonopka.com/2016/serverless-aws-lambda-api-gateway.html) and [melalj/lambda-url-shortner](https://github.com/melalj/lambda-url-shortner)

## API endpoints
- URL: `POST /`
  - apiKey required
  - Params type: `json`
  - Required Params: `table, data, key`
  - Output: `success`

( need more documentation... PR welcome)

## Get started

### Requirements
- [Terraform](https://www.terraform.io/)
- [AWS API Gateway importer](https://github.com/awslabs/aws-apigateway-importer)
- [Apex](https://github.com/apex/apex)

### Commands
```sh
# replace first {{AWS_ACCOUNT_NUMBER}} with you aws account number (command + F is your friend)
terraform apply
aws-api-import -c ./api-swagger.yml # you'll need to follow the instruction on https://github.com/awslabs/aws-apigateway-importer
cd lambda && apex deploy
```

### Test Commands
```sh
cd lambda
echo '{ "table": "test", "key": "testKey", "data": { "row": 1 } }' | apex invoke post
```
