resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 14
  require_uppercase_characters  = true
  require_lowercase_characters  = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  password_reuse_prevention      = 5
}

resource "aws_iam_group" "readonly" {
  name = "readonly-group"
}

resource "aws_iam_policy" "readonly_policy" {
  name        = "readonly-policy"
  description = "Provides read-only access"
  policy      = file("readonly-policy.json")
}

resource "aws_iam_group_policy_attachment" "readonly_attach" {
  group      = aws_iam_group.readonly.name
  policy_arn = aws_iam_policy.readonly_policy.arn
}