#role and policy (module)
module "role_and_policy" {
  source = "git::https://github.com/ZhangMaKe/tf-module-iam-role-and-policy.git?ref=v1.0.0"

  role_name = var.role_name
  service_assuming_role = "apigateway.amazonaws.com"
  role_policies = [
    {
      name = var.policy_name
      actions = ["events:PutEvents"]
      resources = [aws_cloudwatch_event_bus.prediction_game.arn]
    }
  ]
}

#aws_apigatewayv2_integration
resource "aws_apigatewayv2_integration" "eventbridge_integration" {
  api_id = var.api_id
  integration_type = "AWS_PROXY"
  integration_subtype = "EventBridge-PutEvents"
  credentials_arn = module.role_and_policy.role_arn

  request_parameters = {
    "Source" = var.event_source
    "DetailType" = var.event_detailtype
    "Detail" = var.event_detail
    "EventBusName" = var.event_bus_name
  }
}

#api route
resource "aws_apigatewayv2_route" "apigw_route" {
  api_id    = var.api_id
  route_key = "POST /${var.route_key}"
  target    = "integrations/${aws_apigatewayv2_integration.eventbridge_integration.id}"
  authorizer_id = var.authoriser_id
  authorization_type = var.authorisation_type
}