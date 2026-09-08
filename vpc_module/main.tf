resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  enable_dns_hostnames = true

  tags = merge(
        var.common_tags,
        var.vpc_tags,
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

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]
  tags = merge(
    var.common_tags,
    var.publicsubnet_tags,
    {
       Name = "${local.name}-public-${local.azs[count.index]}"
    }

  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]
  tags = merge(
    var.common_tags,
    var.privatesubnet_tags,
    {
       Name = "${local.name}-private-${local.azs[count.index]}"
    }

  )
}

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]
  tags = merge(
    var.common_tags,
    var.databasesubnet_tags,
    {
       Name = "${local.name}-database-${local.azs[count.index]}"
    }

  )
}

resource "aws_eip" "eip" {
  domain   = "vpc"
   tags = {
    Name = "${local.name}-eip"
  }
}

resource "aws_nat_gateway" "mynat" {
  allocation_id                  = aws_eip.eip.allocation_id
  subnet_id                      = aws_subnet.public[0].id
   tags = merge(
    var.common_tags,
    var.natgateway_tags,
    {
        Name = "${local.name}"
    }
   )
   depends_on = [aws_internet_gateway.gw]
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.route_tags,
    {
       Name = "${local.name}-publicrt"
    }

  )
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.route_tags,
    {
       Name = "${local.name}-privatert"
    }

  )
}
resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.route_tags,
    {
       Name = "${local.name}-databasert"
    }

  )
}
resource "aws_route" "public" {
    route_table_id            = aws_route_table.public_rt.id
     destination_cidr_block  = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
resource "aws_route" "private" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.mynat.id
}
resource "aws_route" "database" {
  route_table_id            = aws_route_table.database_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.mynat.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidr)
  subnet_id = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database_rt.id
}