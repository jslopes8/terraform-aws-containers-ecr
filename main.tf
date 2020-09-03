resource "aws_ecr_repository" "main" {
    count = var.create ? 1 : 0

    name                        = var.name_repo
    image_tag_mutability        = var.image_tag_mutability

    dynamic "encryption_configuration" {
        for_each = var.encryption_configuration
        content {
            encryption_type = lookup(encryption_configuration.value, "encryption_type", null)
            kms_key         = lookup(encryption_configuration.value, "kms_key", null)
        }
    }

    dynamic "image_scanning_configuration" {
        for_each = var.image_scanning_configuration
        content {
            scan_on_push = image_scanning_configuration.value.scan_on_push
        }
    }
}
resource "aws_ecr_repository_policy" "main" {
    count = var.create ? length(var.repository_policy) : 0

    repository = aws_ecr_repository.main.0.name
    policy = data.aws_iam_policy_document.policy_document.0.json
}
data "aws_iam_policy_document" "policy_document" {
    count   = var.create ? length(var.repository_policy) : 0

    dynamic "statement" {
        for_each = var.repository_policy
        
        content {
            sid         = lookup(statement.value, "sid", null)
            effect      = lookup(statement.value, "effect", null)
            actions     = lookup(statement.value, "actions", null)
            not_actions = lookup(statement.value, "not_actions", null)
            resources   = lookup(statement.value, "resources", null)

        dynamic "condition" {
          for_each = length(keys(lookup(statement.value, "condition", {}))) == 0 ? [] : [lookup(statement.value, "condition", {})]
          content {
            test      = lookup(condition.value, "test", null)
            variable  = lookup(condition.value, "variable", null)
            values    = lookup(condition.value, "values", null)
            
          }
        }

        dynamic "principals" {
          for_each = length(keys(lookup(statement.value, "principals", {}))) == 0 ? [] : [lookup(statement.value, "principals", {})]
          content {
            type        = lookup(principals.value, "type", null)
            identifiers = lookup(principals.value, "identifiers", null)
          }
        }
      }
    }
}