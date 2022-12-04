resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name: "${var.project_short_name}_public_route_table"
    terraform: "infra"
    stage: var.stage
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public_ingress" {
  count          = 3
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table_association" "public_ingress_1" {
  count          = 3
  subnet_id      = element(aws_subnet.public_subnet_1.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table" "private" {
  count = 3

  vpc_id = aws_vpc.this.id

  tags = {
    Name: "${var.project_short_name}_route_table"
    terraform: "infra"
    stage: var.stage
  }
}

resource "aws_route" "private_egress" {
  count = 3

  destination_cidr_block = "0.0.0.0/0"

  route_table_id = element(
    aws_route_table.private.*.id,
    count.index
  )

  nat_gateway_id = element(
    aws_nat_gateway.static_egress.*.id,
    count.index
  )
}

resource "aws_route_table_association" "internal_private" {
  count          = 1
  subnet_id      = element(aws_subnet.private_ecs.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}