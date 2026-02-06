resource "azurerm_iothub" "iothub" {
  name                = var.iot_name
  resource_group_name = var.rg_name
  location            = var.location
  sku {
    name     = var.iot_sku_name
    capacity = var.iot_sku_capacity
  }
  tags = var.tags
}

# TODO monitor when terraform will add feature to register existing iothub to dps
# at this moment it blocks add new iothub to dps without recreation of it
# https://github.com/hashicorp/terraform-provider-azurerm/issues/5632

resource "azurerm_iothub_shared_access_policy" "default_iothub_policy" {
  name                = format("policy-%s", var.iot_name)
  resource_group_name = var.rg_name
  iothub_name         = var.iot_name

  registry_read   = true
  registry_write  = true
  service_connect = true
  device_connect  = true

  depends_on = [azurerm_iothub.iothub]
}

data "azurerm_iothub" "iot_details" {
  name                = var.iot_name
  resource_group_name = var.rg_name

  depends_on = [azurerm_iothub.iothub]
}

#resource "azurerm_portal_dashboard" "iot_dashboard" {
#  name                = format("%s-monitor", var.iot_name)
#  resource_group_name = var.rg_name
#  location            = var.location
#  tags = var.tags
#
#  depends_on = [ azurerm_iothub.iothub ]
#  dashboard_properties = <<DASH
#{
#  "properties": {
#    "lenses": {
#      "0": {
#        "order": 0,
#        "parts": {
#          "0": {
#            "position": {
#              "x": 0,
#              "y": 0,
#              "colSpan": 2,
#              "rowSpan": 9
#            },
#            "metadata": {
#              "inputs": [],
#              "type": "Extension/HubsExtension/PartType/MarkdownPart",
#              "settings": {
#                "content": {
#                  "settings": {
#                    "content": "# Health\nTrend of your IOT hub health over past 30 days.",
#                    "title": "",
#                    "subtitle": "",
#                    "markdownSource": 1,
#                    "markdownUri": null
#                  }
#                }
#              }
#            }
#          },
#          "1": {
#            "position": {
#              "x": 2,
#              "y": 0,
#              "colSpan": 7,
#              "rowSpan": 6
#            },
#            "metadata": {
#              "inputs": [
#                {
#                  "name": "options",
#                  "value": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "connectedDeviceCount",
#                          "aggregationType": 3,
#                          "metricVisualization": {
#                            "displayName": "Connected devices",
#                            "resourceDisplayName": "${data.azurerm_iothub.iot_details.name}"
#                          }
#                        }
#                      ],
#                      "title": "Connected Devices",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2
#                      },
#                      "openBladeOnClick": {
#                        "openBlade": true
#                      }
#                    }
#                  },
#                  "isOptional": true
#                },
#                {
#                  "name": "sharedTimeRange",
#                  "isOptional": true
#                }
#              ],
#              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
#              "settings": {
#                "content": {
#                  "options": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "connectedDeviceCount",
#                          "aggregationType": 3,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Connected devices",
#                            "resourceDisplayName": "${data.azurerm_iothub.iot_details.name}"
#                          }
#                        },
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "totalDeviceCount",
#                          "aggregationType": 3,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Total devices",
#                            "resourceDisplayName": "${data.azurerm_iothub.iot_details.name}"
#                          }
#                        }
#                      ],
#                      "title": "Connected Devices",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        },
#                        "disablePinning": true
#                      }
#                    }
#                  }
#                }
#              }
#            }
#          },
#          "2": {
#            "position": {
#              "x": 9,
#              "y": 0,
#              "colSpan": 6,
#              "rowSpan": 3
#            },
#            "metadata": {
#              "inputs": [
#                {
#                  "name": "options",
#                  "value": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "EventGridLatency",
#                          "aggregationType": 4,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Event Grid latency"
#                          }
#                        }
#                      ],
#                      "title": "Avg Event Grid latency for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 1,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        }
#                      },
#                      "timespan": {
#                        "relative": {
#                          "duration": 86400000
#                        },
#                        "showUTCTime": false,
#                        "grain": 1
#                      }
#                    }
#                  },
#                  "isOptional": true
#                },
#                {
#                  "name": "sharedTimeRange",
#                  "isOptional": true
#                }
#              ],
#              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
#              "settings": {
#                "content": {
#                  "options": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "EventGridLatency",
#                          "aggregationType": 4,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Event Grid latency"
#                          }
#                        }
#                      ],
#                      "title": "Avg Event Grid latency for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 1,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        },
#                        "disablePinning": true
#                      }
#                    }
#                  }
#                }
#              }
#            }
#          },
#          "3": {
#            "position": {
#              "x": 9,
#              "y": 3,
#              "colSpan": 6,
#              "rowSpan": 3
#            },
#            "metadata": {
#              "inputs": [
#                {
#                  "name": "options",
#                  "value": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "d2c.telemetry.ingress.sendThrottle",
#                          "aggregationType": 4,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Number of throttling errors"
#                          }
#                        }
#                      ],
#                      "title": "Avg Number of throttling errors for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 1,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        }
#                      },
#                      "timespan": {
#                        "relative": {
#                          "duration": 86400000
#                        },
#                        "showUTCTime": false,
#                        "grain": 1
#                      }
#                    }
#                  },
#                  "isOptional": true
#                },
#                {
#                  "name": "sharedTimeRange",
#                  "isOptional": true
#                }
#              ],
#              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
#              "settings": {
#                "content": {
#                  "options": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "d2c.telemetry.ingress.sendThrottle",
#                          "aggregationType": 4,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Number of throttling errors"
#                          }
#                        }
#                      ],
#                      "title": "Avg Number of throttling errors for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 1,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        },
#                        "disablePinning": true
#                      }
#                    }
#                  }
#                }
#              }
#            }
#          },
#          "4": {
#            "position": {
#              "x": 2,
#              "y": 6,
#              "colSpan": 7,
#              "rowSpan": 3
#            },
#            "metadata": {
#              "inputs": [
#                {
#                  "name": "options",
#                  "value": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "dailyMessageQuotaUsed",
#                          "aggregationType": 4,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Total number of messages used"
#                          }
#                        }
#                      ],
#                      "title": "Avg Total number of messages used for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 1,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        }
#                      },
#                      "timespan": {
#                        "relative": {
#                          "duration": 86400000
#                        },
#                        "showUTCTime": false,
#                        "grain": 1
#                      }
#                    }
#                  },
#                  "isOptional": true
#                },
#                {
#                  "name": "sharedTimeRange",
#                  "isOptional": true
#                }
#              ],
#              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
#              "settings": {
#                "content": {
#                  "options": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "dailyMessageQuotaUsed",
#                          "aggregationType": 3,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Total number of messages used"
#                          }
#                        }
#                      ],
#                      "title": "Total number of messages used for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        },
#                        "disablePinning": true
#                      }
#                    }
#                  }
#                }
#              }
#            }
#          },
#          "5": {
#            "position": {
#              "x": 9,
#              "y": 6,
#              "colSpan": 6,
#              "rowSpan": 3
#            },
#            "metadata": {
#              "inputs": [
#                {
#                  "name": "options",
#                  "value": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "deviceDataUsage",
#                          "aggregationType": 4,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Total device data usage"
#                          }
#                        }
#                      ],
#                      "title": "Avg Total device data usage for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 1,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        }
#                      },
#                      "timespan": {
#                        "relative": {
#                          "duration": 86400000
#                        },
#                        "showUTCTime": false,
#                        "grain": 1
#                      }
#                    }
#                  },
#                  "isOptional": true
#                },
#                {
#                  "name": "sharedTimeRange",
#                  "isOptional": true
#                }
#              ],
#              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
#              "settings": {
#                "content": {
#                  "options": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "deviceDataUsage",
#                          "aggregationType": 1,
#                          "namespace": "microsoft.devices/iothubs",
#                          "metricVisualization": {
#                            "displayName": "Total device data usage"
#                          }
#                        }
#                      ],
#                      "title": "Total device data usage for ${data.azurerm_iothub.iot_details.name}",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2,
#                        "legendVisualization": {
#                          "isVisible": true,
#                          "position": 2,
#                          "hideSubtitle": false
#                        },
#                        "axisVisualization": {
#                          "x": {
#                            "isVisible": true,
#                            "axisType": 2
#                          },
#                          "y": {
#                            "isVisible": true,
#                            "axisType": 1
#                          }
#                        },
#                        "disablePinning": true
#                      }
#                    }
#                  }
#                }
#              }
#            }
#          },
#          "6": {
#            "position": {
#              "x": 0,
#              "y": 9,
#              "colSpan": 2,
#              "rowSpan": 3
#            },
#            "metadata": {
#              "inputs": [],
#              "type": "Extension/HubsExtension/PartType/MarkdownPart",
#              "settings": {
#                "content": {
#                  "content": "# Telemetry\nIOT hub telemetry over the past 48 hours.",
#                  "title": "",
#                  "subtitle": "",
#                  "markdownSource": 1,
#                  "markdownUri": {}
#                }
#              }
#            }
#          },
#          "7": {
#            "position": {
#              "x": 2,
#              "y": 9,
#              "colSpan": 7,
#              "rowSpan": 3
#            },
#            "metadata": {
#              "inputs": [
#                {
#                  "name": "options",
#                  "value": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "dailyMessageQuotaUsed",
#                          "aggregationType": 3,
#                          "metricVisualization": {
#                            "displayName": "Total number of messages used",
#                            "resourceDisplayName": "${data.azurerm_iothub.iot_details.name}"
#                          }
#                        }
#                      ],
#                      "title": "Number of messages used",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2
#                      },
#                      "openBladeOnClick": {
#                        "openBlade": true
#                      }
#                    }
#                  },
#                  "isOptional": true
#                },
#                {
#                  "name": "sharedTimeRange",
#                  "isOptional": true
#                }
#              ],
#              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
#              "settings": {
#                "content": {
#                  "options": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "dailyMessageQuotaUsed",
#                          "aggregationType": 3,
#                          "metricVisualization": {
#                            "displayName": "Total number of messages used",
#                            "resourceDisplayName": "${data.azurerm_iothub.iot_details.name}"
#                          }
#                        }
#                      ],
#                      "title": "Number of messages used",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2,
#                        "disablePinning": true
#                      },
#                      "openBladeOnClick": {
#                        "openBlade": true
#                      }
#                    }
#                  }
#                }
#              },
#              "filters": {
#                "MsPortalFx_TimeRange": {
#                  "model": {
#                    "format": "local",
#                    "granularity": "auto",
#                    "relative": "2880m"
#                  }
#                }
#              }
#            }
#          },
#          "8": {
#            "position": {
#              "x": 9,
#              "y": 9,
#              "colSpan": 6,
#              "rowSpan": 3
#            },
#            "metadata": {
#              "inputs": [
#                {
#                  "name": "options",
#                  "value": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "d2c.telemetry.ingress.success",
#                          "aggregationType": 7,
#                          "metricVisualization": {
#                            "displayName": "Telemetry messages sent",
#                            "resourceDisplayName": "${data.azurerm_iothub.iot_details.name}"
#                          }
#                        }
#                      ],
#                      "title": "Device to cloud messages",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2
#                      },
#                      "openBladeOnClick": {
#                        "openBlade": true
#                      }
#                    }
#                  },
#                  "isOptional": true
#                },
#                {
#                  "name": "sharedTimeRange",
#                  "isOptional": true
#                }
#              ],
#              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
#              "settings": {
#                "content": {
#                  "options": {
#                    "chart": {
#                      "metrics": [
#                        {
#                          "resourceMetadata": {
#                            "id": "${data.azurerm_iothub.iot_details.id}"
#                          },
#                          "name": "d2c.telemetry.ingress.success",
#                          "aggregationType": 7,
#                          "metricVisualization": {
#                            "displayName": "Telemetry messages sent",
#                            "resourceDisplayName": "${data.azurerm_iothub.iot_details.name}"
#                          }
#                        }
#                      ],
#                      "title": "Device to cloud messages",
#                      "titleKind": 2,
#                      "visualization": {
#                        "chartType": 2,
#                        "disablePinning": true
#                      },
#                      "openBladeOnClick": {
#                        "openBlade": true
#                      }
#                    }
#                  }
#                }
#              },
#              "filters": {
#                "MsPortalFx_TimeRange": {
#                  "model": {
#                    "format": "local",
#                    "granularity": "auto",
#                    "relative": "2880m"
#                  }
#                }
#              }
#            }
#          }
#        }
#      }
#    },
#    "metadata": {
#      "model": {
#        "timeRange": {
#          "value": {
#            "relative": {
#              "duration": 24,
#              "timeUnit": 1
#            }
#          },
#          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
#        },
#        "filterLocale": {
#          "value": "en-us"
#        },
#        "filters": {
#          "value": {
#            "MsPortalFx_TimeRange": {
#              "model": {
#                "format": "local",
#                "granularity": "auto",
#                "relative": "30d"
#              },
#              "displayCache": {
#                "name": "Local Time",
#                "value": "Past 30 days"
#              },
#              "filteredPartIds": [
#                "StartboardPart-MonitorChartPart-2d65277b-1f2d-4aff-a6b6-4692a589113f",
#                "StartboardPart-MonitorChartPart-2d65277b-1f2d-4aff-a6b6-4692a5891141",
#                "StartboardPart-MonitorChartPart-2d65277b-1f2d-4aff-a6b6-4692a5891143",
#                "StartboardPart-MonitorChartPart-2d65277b-1f2d-4aff-a6b6-4692a5891145",
#                "StartboardPart-MonitorChartPart-2d65277b-1f2d-4aff-a6b6-4692a5891147",
#                "StartboardPart-MonitorChartPart-2d65277b-1f2d-4aff-a6b6-4692a589114b",
#                "StartboardPart-MonitorChartPart-2d65277b-1f2d-4aff-a6b6-4692a589114d"
#              ]
#            }
#          }
#        }
#      }
#    }
#  },
#  "name": "iot-d-nonlatam-01-monitor",
#  "type": "Microsoft.Portal/dashboards",
#  "location": "INSERT LOCATION",
#  "tags": {
#    "hidden-title": "iot-d-nonlatam-01-monitor"
#  },
#  "apiVersion": "2015-08-01-preview"
#}
#DASH
#}