# output_main_variable.tf

# 로컬 변수를 사용하여 출력 값을 한 곳에서 정의합니다.
locals {
  outputs = {
    instances_info = {
      for instance_name, instance in module.ec2_instance :
      instance_name => {
        instance_id  = instance.instance_id
        private_ip   = instance.instance_private_ip
        public_ip    = instance.instance_public_ip
      }
    }
  }
}

# 출력 블록에서 로컬 변수를 사용하여 값을 출력합니다.
output "instances_info" {
  value       = local.outputs.instances_info
  description = "각 인스턴스 이름에 따른 EC2 인스턴스 정보 (ID, 사설 IP, 공인 IP)"
}

# S3에 outputs.json 파일을 업로드하는 리소스입니다.
resource "aws_s3_object" "outputs" {
  bucket = module.s3_buckets["ktb21-load-test-cloud"].bucket_id
  key    = "terraform/outputs.json"
  content = jsonencode(local.outputs)
  acl    = "private"  # 데이터 보호를 위해 파일 접근 권한 설정

  depends_on = [
    module.ec2_instance,
    module.s3_buckets
  ]
  
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}