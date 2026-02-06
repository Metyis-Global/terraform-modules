variable "metric_alert_name" {
  type        = string
  description = "The name of the Metric Alert"
}

variable "scopes" {
  type        = string
  description = "A set of strings of resource IDs at which the metric criteria should be applied"
}

variable "rg_name" {
  type        = string
  description = "The name of an existing resource group"
}

variable "description" {
  type        = string
  description = " The description of this Metric Alert"
}

variable "metric_namespace" {
  type        = string
  description = "One of the metric namespaces to be monitored"
}

variable "metric_name" {
  type        = string
  description = "One of the metric names to be monitored"
}

variable "aggregation" {
  type        = string
  description = "The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total"
}

variable "operator" {
  type        = string
  description = "The criteria operator. Possible values are Equals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual"
}

variable "threshold" {
  type        = string
  description = "The criteria threshold value that activates the alert"
}