# Serverless Dynamodb API

This repo contains components to push data in DynamoDB datastore

Inspiration from: [Build a serverless URL shortener with AWS Lambda and API Gateway services](http://www.davekonopka.com/2016/serverless-aws-lambda-api-gateway.html)

## Getting started

### Required AWS resources

The `main.tf` [Terraform](https://www.terraform.io/) file contains basic resources required for DynamoDB including a table and IAM role with associated policies.

To use this [install and configure Terraform](https://www.terraform.io/intro/getting-started/install.html) for your AWS account.

```
terraform apply
```

### API Gateway

[redir-v1-swagger.yml](redir-v1-swagger.yml) contains a [Swagger](http://swagger.io/getting-started/) YAML definition for the front-end interface. This can be imported into your AWS using Amazon's [API Gateway Importer](https://github.com/awslabs/aws-apigateway-importer).

**NOTE**: References to Amazon account id have been replaced with `{{AWS_ACCOUNT_NUMBER}}`. You will need to change these to your numeric AWS account id.

### Lambda Functions

All Lambda functions are organized under `lambda` using the [Apex framework](http://apex.run/).

**NOTE**: References to Amazon account id have been replaced with `{{AWS_ACCOUNT_NUMBER}}`. You will need to change these to your numeric AWS account id.

Once you [install Apex](http://apex.run/#installation), you can deploy via the CLI:

```
> cd lambda
> apex deploy
```

And execute locally via the CLI:

```
> cd lambda
> echo '{ "table": "test", "key": "xxxxx", "data" : { "row1" : 1 } }' | apex invoke post
```
