data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["${var.ipfs_github_credentials_arn}"]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = [
      "${var.ipfs_github_credentials_arn}",
      "${var.ipfs_kms_key_arn}"
    ]
  }
}


resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}
resource "aws_iam_role" "ipfs_ecs_task_execution_role" {
  name               = "${var.task_family}-execution-role"
  assume_role_policy = var.ecs_assume_role_policy
}

resource "aws_iam_role_policy_attachment" "ipfs_ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ipfs_ecs_task_execution_role.name
  policy_arn = var.ecs_role_policy_arn
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ipfs_ecs_task_execution_role.name
  policy_arn = aws_iam_policy.policy.arn
}
