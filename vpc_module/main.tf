resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  enable_dns_hostnames = true

  tags = merge(
        var.common_tags,
        var.resource_tags,
        {
            Name = locals.name
        }
    )
  }
