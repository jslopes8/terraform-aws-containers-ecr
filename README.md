# Terraform Module AWS ECR Registry

Terraform module irá provisionar os seguintes recursos:

* [ECR Repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)
* [ECR Repository Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy)
* [ECR Lifecycle Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy)

Se o build da sua imagem docker for realizado atravez do seu Git, usar o argumento `git_source_url`, se o build for local, informar o diretorio com o argumento `docker_source_path`.

- Importante!
- Deverá configurar um AWS Profile em qualquer um dos arquivos `~/.aws/config` ou `~/.aws/credentials`. Especificando o id da conta para a execução do docker login.

# Usage
Exemplo de Uso: Criando um Repositorio, fazendo o docker build atraves de um Git.
```hcl
module "ecr_repo" {
  source = "git@github.com:jslopes8/terraform-aws-containers-ecr.git?ref=v1.1"

  name_repo               = local.repo_name
  image_tag_mutability    = "IMMUTABLE"

  image_scanning_configuration = [{
    scan_on_push    = "true"
  }]

  git_source_url        = "git@github.com:jslopes8/demo-php-ecs.git"
  docker_image_name     = local.repo_name
  docker_image_tag      = local.image_tags

  lifecycle_policy = [
    {
        rulePriority        = "1"
        ruleActionType      = "expire"
        ruleDescription     = "Keep last 14 images"
        ruleTagStatus       = "tagged"
        ruleTagPrefixList   = "v"
        ruleCountType       = "imageCountMoreThan"
        ruleCountUnit       = "days"
        ruleCountNumber     = "14"
    }
  ]

  default_tags = local.tags
}
```

## Requirements
| Name | Version |
| ---- | ------- |
| aws | ~> 3.18 |
| terraform | ~> 0.13 |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Variables Inputs
| Name | Description | Required | Type | Default |
| ---- | ----------- | -------- | ---- | ------- |
| name | O nome do seu repositorio ECR. | `yes` | `string` | `[]` |
| image_tag_mutability | Defina se as tags para o repositorio será imutavel ou não. Valores validos `MUTABLE`, `IMMUTABLE`. | `no` | `string` | `MUTABLE` |
| encryption_configuration | Uma lista de configuração para criptografar seu repositorio. | `no` | `list` | `[]` |
| image_scanning_configuration | Bloco de configuração que define a configuração de digitalização de imagem para o repositório. | `no` | `list` | `[]` |
| default_tags | | `no` | `map` | `{}` |
| repository_policy | Bloco de configuração para definir politica para o seu repositorio. Mesmo modelo de configuração de IAM Policy. | `no` | `list` | `[]` |
| lifecycle_policy | Bloco de configuração para definir um ciclo de vida de suas imagem no repositorio. | `no` | `list` | `[]` |
| git_source_url | Uma URL do seu Git que será realizado o docker build. Na raiz do projeto deverá conter o dockerfile. | `no` | `string` | `null` |
| docker_source_path | O diretorio local do seu projeto para realizar o docker build. Na raiz deste diretorio deverá conter o dockerfile. | `no` | `string` | `null` |
| docker_image_name | O nome da sua image. | `yes` | `string` | ` ` |
| docker_image_tag | O nome da versão que será implantada a sua imagem docker. | `yes` | `string` | ` ` |
 
## Variable Outputs
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
| Name | Description |
| ---- | ----------- |
| repo_url | A URL do seu repositorio criado. |
| repo_id | O id do seu repositeorio criado. |
| repo_arn | O ARN do seu repositorio criado. |
