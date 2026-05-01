module "courses_label" {
  source    = "cloudposse/label/null"
  version   = "0.25.0"
  namespace = var.namespace
  stage     = var.stage
  name      = "courses"
}

module "authors_label" {
  source    = "cloudposse/label/null"
  version   = "0.25.0"
  namespace = var.namespace
  stage     = var.stage
  name      = "authors"
}

module "courses_table" {
  source     = "./modules/dynamodb"
  table_name = module.courses_label.id
}

module "authors_table" {
  source     = "./modules/dynamodb"
  table_name = module.authors_label.id
}