variable "name" {
  type        = string
  description = "Key pair name."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Tags map."
}
