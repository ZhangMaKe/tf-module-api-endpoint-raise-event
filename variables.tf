variable "role_name" {
  description = "The name of the IAM role to create."
  type = string
}

variable "policy_name" {
  description = "The name of the IAM policy to create."
  type = string
}

variable "api_id" {
  description = "The ID of the (v2) API Gateway to create the integration for."
  type = string
}

variable "event_source" {
  description = "The 'Source' field for the EventBridge event to trigger."
  type = string
}

variable "event_detailtype" {
  description = "The 'DetailType' field for the EventBridge event to trigger."
  type = string
}

variable "event_detail" {
  description = "The 'EventDetail' field for the EventBridge event to trigger."
  type = string
  default = "$request.body"
}

variable "event_bus_name" {
    description = "The name of the EventBridge event bus to create the integration with."
    type = string
}

variable "event_bus_arn" {
    description = "The ARN of the EventBridge event bus to create the integration with."
    type = string
}

variable "route_key" {
  description = "The route key for the API Gateway route to create to trigger the event."
  type = string
}

variable "authoriser_id" {
  description = "The ID of the Lambda authorizer to use for the API Gateway route."
  type        = string
  default     = null
}

variable "authorisation_type" {
  description = "The type of authorization for the API Gateway route."
  type        = string
  default     = "NONE"
  validation {
    condition     = contains(["NONE", "AWS_IAM", "CUSTOM", "JWT"], var.authorisation_type)
    error_message = "Authorization type must be one of: NONE, AWS_IAM, JWT, or CUSTOM."
  }
}