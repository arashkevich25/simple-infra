resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.this.id
    availability_zone = var.azs[0]
    cidr_block = var.subnet_cidr_block

    depends_on = [aws_internet_gateway.gw]

    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_private_subnet"
    } 
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.this.id
    availability_zone = var.azs[1]
    cidr_block = var.subnet_cidr_block_1

    depends_on = [aws_subnet.private_subnet]

    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_private_subnet"
    } 
}

resource "aws_subnet" "private_ecs" {
    vpc_id = aws_vpc.this.id
    availability_zone = var.azs[1]
    cidr_block = var.subnet_cidr_block_2

    depends_on = [aws_subnet.private_subnet]

    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_private_ecs_subnet"
    } 
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.this.id
    availability_zone = var.azs[2]
    cidr_block = var.subnet_cidr_public_block
    map_public_ip_on_launch = true

    depends_on = [aws_subnet.private_subnet_1]

    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_public_subnet"
    } 
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.this.id
    availability_zone = var.azs[0]
    cidr_block = var.subnet_cidr_public_block_1
    map_public_ip_on_launch = true

    depends_on = [aws_subnet.private_subnet_1]

    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_public_subnet"
    } 
}