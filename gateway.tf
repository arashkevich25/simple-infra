resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id

  depends_on = [aws_vpc.this]

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_gw"
  } 
}
resource "aws_nat_gateway" "static_egress" {
  count = 3

  allocation_id = element(aws_eip.egress.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name: "${var.project_short_name}_nat_gateway"
    terraform: "infra"
    stage: var.stage
  }
}