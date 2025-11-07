# API Gateway Event Bridge Integration Terraform Module

This Terraform module creates an API Gateway V2 integration with EventBridge, allowing you to trigger EventBridge events through API Gateway endpoints. It sets up the necessary IAM roles and policies, creates an API Gateway integration, and configures the route with optional authorization.

## Features

- Creates an API Gateway V2 integration with EventBridge.
- Sets up IAM role and policy for API Gateway to publish events to EventBridge
- Configures API Gateway route with customizable authorization
- Supports custom event source, detail type, and event bus name


## Usage

```hcl
module "api_event_integration" {
  source = "git::https://github.com/ZhangMaKe/tf-module-api-endpoint-raise-event.git"

  role_name           = "my-api-eventbridge-role"
  policy_name         = "my-api-eventbridge-policy"
  api_id              = "my-api-id"
  event_source        = "my.custom.source"
  event_detailtype    = "MyCustomEvent"
  event_detail        = "$request.body"
  event_bus_name      = "my-event-bus"
  event_bus_arn       = "arn:aws:events:eu-west-2:1234567890:event-bus/my-event-bus"
  route_key           = "trigger-event"
  authorisation_type  = "NONE"  # Optional, defaults to "NONE"
}
```

## Requirements

- AWS Terraform Provider
- An existing API Gateway V2 API
- An existing EventBridge event bus (if using a custom bus)

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| role_name | The name of the IAM role to create | `string` | - | yes |
| policy_name | The name of the IAM policy to create | `string` | - | yes |
| api_id | The ID of the (v2) API Gateway to create the integration for | `string` | - | yes |
| event_source | The 'Source' field for the EventBridge event to trigger | `string` | - | yes |
| event_detailtype | The 'DetailType' field for the EventBridge event to trigger | `string` | - | yes |
| event_detail | The 'EventDetail' field for the EventBridge event to trigger | `string` | "$request.body" | no |
| event_bus_name | The name of the EventBridge event bus to create the integration with | `string` | - | yes |
| event_bus_arn | The ARN of the EventBridge event bus to create the integration with | `string` | - | yes |
| route_key | The route key for the API Gateway route to create to trigger the event | `string` | - | yes |
| authoriser_id | The ID of the Lambda authorizer to use for the API Gateway route | `string` | `null` | no |
| authorisation_type | The type of authorization for the API Gateway route (NONE, AWS_IAM, CUSTOM, JWT) | `string` | "NONE" | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | The ARN of the IAM role created for API Gateway to assume |
| policy_arns | A list of the IDs of the created IAM policies |
| integration_id | The value of the created API Gateway V2 integration |
| route_id | The ID of the created API Gateway V2 route |

## Limitations / Additional Information

1. This module only supports API Gateway V2 (HTTP APIs), not the REST API (V1)
2. When using custom authorization, the authorizer must be created separately and its ID provided
4. The module currently only supports POST method for the API Gateway route
5. The IAM role created will only have permissions to publish events to the specified EventBridge bus

## Security Considerations

- Consider using appropriate authorization (AWS_IAM, JWT, or Custom) instead of NONE for production environments
- The IAM role permissions are scoped to only allow PutEvents to the specified EventBridge bus
- When using custom authorizers, ensure they properly validate the requests before allowing them through

## Contributing

Feel free to submit issues and enhancement requests!