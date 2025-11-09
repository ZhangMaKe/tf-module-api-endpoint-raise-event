output "role_arn" {
  description = "The ARN of the IAM role created for API Gateway to assume."
  value       = module.role_and_policy.role_arn
}

output "policy_arns" {
    description = "A list of the IDs of the created IAM policies."
    value = module.role_and_policy.policy_arns
}

output "integration_id" {
    description = "The value of the created API Gateway V2 integration."
    value = aws_apigatewayv2_integration.eventbridge_integration.id
}

output "route_id" {
    description = "The ID of the created API Gateway V2 route."
    value = aws_apigatewayv2_route.apigw_route.id
}

output "event_rule_name" {
    description = "The name of the create EventBridge event rule."
    value = aws_cloudwatch_event_rule.event_rule.id
}

output "event_rule_arn" {
    description = "The ARN of the create EventBridge event rule."
    value = aws_cloudwatch_event_rule.event_rule.arn
}