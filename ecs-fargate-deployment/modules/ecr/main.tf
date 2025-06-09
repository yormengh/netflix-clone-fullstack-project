resource "aws_ecr_repository" "app" {
  count = 2
  name  = "${var.app_name}-app${count.index + 1}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}