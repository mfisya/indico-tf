variable "vpc_id" {
  description = "The ID of the VPC where the route table will be created"
  type        = string
}

variable "routes" {
  description = "A list of route objects to be added to the route table"
  type = list(object({
    cidr_block = string
    gateway_id = string
  }))
}
