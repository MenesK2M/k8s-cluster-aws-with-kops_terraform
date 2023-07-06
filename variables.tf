variable "security_group" {
  description = "Object to structure the SG dynamic block"
  type = map(object({
    description = string
    port        = number
    port2       = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    "ssh" = {
      description = "Allow SSH communication"
      port        = 22
      port2       = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "http" = {
      description = "Allow HTTP communication"
      port        = 8080
      port2       = 8089
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "iam_role" {
  type    = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/IAMFullAccess", "arn:aws:iam::aws:policy/AmazonVPCFullAccess", "arn:aws:iam::aws:policy/AmazonRoute53FullAccess", "arn:aws:iam::aws:policy/AmazonSQSFullAccess", "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"]
}

variable "passwd" {
  type    = string
  default = "test123"
}