resource "aws_ecr_repository" "fam-api-ecr" {
    name  = "${var.project_short_name}-api"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }

    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_ecr"
    } 
}
