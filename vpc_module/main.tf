resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  enable_dns_hostnames = true

  tags = merge(
        var.common_tags,
        var.resource_tags,
        {
            Name = local.name
        }
    )
  }
  resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags,
                var.igw_tags,
                {
                Name = local.name
                }
        )
}
