output "repo_url" {
    value = aws_ecr_repository.main.*.repository_url
}
output "repo_id" {
    value = aws_ecr_repository.main.*.registry_id
}
output "repo_arn" {
    value = aws_ecr_repository.main.*.arn
}