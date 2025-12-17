variable "cost_management_export_name" {
  description = "Specifies the name of the Cost Management Export"
  type        = string
}

variable "subscription_id" {
  description = "The id of the subscription on which to create an export. Changing this forces a new resource to be created"
  type        = string
}

variable "recurrence_type" {
  description = "How often the requested information will be exported. Valid values include Annually, Daily, Monthly, Weekly."
  type        = string
}

variable "period_start_date" {
  description = "The date the export will start capturing information."
  type        = string
}

variable "period_end_date" {
  description = "The date the export will stop capturing information."
  type        = string
}

variable "container_id" {
  description = "The Resource Manager ID of the container where exports will be uploaded"
  type        = string
}

variable "root_folder_path" {
  description = "The path of the directory where exports will be uploaded"
  type        = string
}

variable "type" {
  description = "The type of the query. Possible values are ActualCost, AmortizedCost and Usage."
  type        = string
}

variable "time_frame" {
  description = "The time frame for pulling data for the query. If custom, then a specific time period must be provided. Possible values include: WeekToDate, MonthToDate, BillingMonthToDate, TheLast7Days, TheLastMonth, TheLastBillingMonth, Custom"
  type        = string
}

