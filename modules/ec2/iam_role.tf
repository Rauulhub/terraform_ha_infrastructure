resource "aws_iam_role" "ec2-ssm" {
  name = "ec2-ssm"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
# Política personalizada para acceso a S3
resource "aws_iam_policy" "s3_access_policy" {
  name        = "managementS3Access"
  description = "Policy to allow access to a specific S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowS3ReadAccess"
        Effect    = "Allow"
        Action    = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource  = [
          "arn:aws:s3:::lab-final-backend",
          "arn:aws:s3:::lab-final-backend/*"
        ]
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ec2-ssm-policy" {
  role       = aws_iam_role.ec2-ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
# Adjuntar la política de S3 al rol
resource "aws_iam_role_policy_attachment" "ec2-s3-policy-attachment" {
  role       = aws_iam_role.ec2-ssm.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
resource "aws_iam_instance_profile" "ec2-profile_private" {
  name = "ec2_ssm_private"
  role = aws_iam_role.ec2-ssm.name
}