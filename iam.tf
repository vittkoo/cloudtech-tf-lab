data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# 1. get-all-authors
resource "aws_iam_role" "get_all_authors_role" {
  name               = "${var.namespace}-${var.stage}-get-all-authors-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "get_all_authors_policy" {
  name = "get-all-authors-policy"
  role = aws_iam_role.get_all_authors_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "dynamodb:Scan"
        Resource = module.authors_table.table_arn
      }
    ]
  })
}

# 2. save-course
resource "aws_iam_role" "save_course_role" {
  name               = "${var.namespace}-${var.stage}-save-course-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "save_course_policy" {
  name = "save-course-policy"
  role = aws_iam_role.save_course_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "dynamodb:PutItem"
        Resource = module.courses_table.table_arn
      }
    ]
  })
}

# 3. get-all-courses
resource "aws_iam_role" "get_all_courses_role" {
  name               = "${var.namespace}-${var.stage}-get-all-courses-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "get_all_courses_policy" {
  name = "get-all-courses-policy"
  role = aws_iam_role.get_all_courses_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "dynamodb:Scan"
        Resource = module.courses_table.table_arn
      }
    ]
  })
}

# 4. get-course
resource "aws_iam_role" "get_course_role" {
  name               = "${var.namespace}-${var.stage}-get-course-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "get_course_policy" {
  name = "get-course-policy"
  role = aws_iam_role.get_course_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "dynamodb:GetItem"
        Resource = module.courses_table.table_arn
      }
    ]
  })
}

# 5. delete-course
resource "aws_iam_role" "delete_course_role" {
  name               = "${var.namespace}-${var.stage}-delete-course-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "delete_course_policy" {
  name = "delete-course-policy"
  role = aws_iam_role.delete_course_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "dynamodb:DeleteItem"
        Resource = module.courses_table.table_arn
      }
    ]
  })
}

# 6. update-course
resource "aws_iam_role" "update_course_role" {
  name               = "${var.namespace}-${var.stage}-update-course-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "update_course_policy" {
  name = "update-course-policy"
  role = aws_iam_role.update_course_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "dynamodb:PutItem"
        Resource = module.courses_table.table_arn
      }
    ]
  })
}