# 지역 설정
region = "ap-northeast-2"

vpc_config = {
    name       = "ktb21-loadTest"
    cidr_block = "192.168.0.0/16"
}

# Subnet
public_subnets = {
    "public1" = {
        cidr_block        = "192.168.1.0/24"
        availability_zone = "ap-northeast-2a"
    },
    "public2" = {
        cidr_block        = "192.168.2.0/24"
        availability_zone = "ap-northeast-2b"
    },
    "public3" = {
        cidr_block        = "192.168.3.0/24"
        availability_zone = "ap-northeast-2c"
    },
    "public4" = {
        cidr_block        = "192.168.4.0/24"
        availability_zone = "ap-northeast-2d"
    }
}

private_subnets = {
  "private1" = {
    cidr_block = "192.168.10.0/24"
    availability_zone = "ap-northeast-2a"
  }
}

# Security Groups
# 사용하지 않으면: sg = []
sg = [
  { 
    name    = "ssh"
    ingress = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  { 
    name    = "front-nextjs"
    ingress = [
      {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  { 
    name    = "back-nodejs"
    ingress = [
      {
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  { 
    name    = "db-redis"
    ingress = [
      {
        from_port   = 6379
        to_port     = 6379
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  { 
    name    = "db-mongodb"
    ingress = [
      {
        from_port   = 27017
        to_port     = 27017
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
 
]

# EC2
# 사용하지 않으면: intances = []
instances = [
  {
    name                 = "front"
    ami                  = "ami-0f1e61a80c7ab943e"
    instance_type        = "t3.small"
    volume               = 20
    is_public            = true # 퍼블릭 인스턴스일때 true / 프라이빗 인스턴스일때 false
    subnet_name          = "public1"
    security_group_names = ["ssh"]
  },
  {
    name                 = "back"
    ami                  = "ami-0f1e61a80c7ab943e"
    instance_type        = "t3.small"
    volume               = 20
    is_public            = true # 퍼블릭 인스턴스일때 true / 프라이빗 인스턴스일때 false
    subnet_name          = "public1"
    security_group_names = ["ssh"]
  },
  {
    name                 = "redis"
    ami                  = "ami-0f1e61a80c7ab943e"
    instance_type        = "t3.small"
    volume               = 20
    is_public            = true # 퍼블릭 인스턴스일때 true / 프라이빗 인스턴스일때 false
    subnet_name          = "public1"
    security_group_names = ["ssh"]
  },
  {
    name                 = "mongoDB"
    ami                  = "ami-0f1e61a80c7ab943e"
    instance_type        = "t3.small"
    volume               = 20
    is_public            = true # 퍼블릭 인스턴스일때 true / 프라이빗 인스턴스일때 false
    subnet_name          = "public1"
    security_group_names = ["ssh"]
  },
  {
    name                 = "metrics"
    ami                  = "ami-0f1e61a80c7ab943e"
    instance_type        = "t3.small"
    volume               = 20
    is_public            = true # 퍼블릭 인스턴스일때 true / 프라이빗 인스턴스일때 false
    subnet_name          = "public1"
    security_group_names = ["ssh"]
  },
  {
    name                 = "stress1"
    ami                  = "ami-0f1e61a80c7ab943e"
    instance_type        = "t3.small"
    volume               = 20
    is_public            = true # 퍼블릭 인스턴스일때 true / 프라이빗 인스턴스일때 false
    subnet_name          = "public1"
    security_group_names = ["ssh"]
  },
  {
    name                 = "stress2"
    ami                  = "ami-0f1e61a80c7ab943e"
    instance_type        = "t3.small"
    volume               = 20
    is_public            = true # 퍼블릭 인스턴스일때 true / 프라이빗 인스턴스일때 false
    subnet_name          = "public1"
    security_group_names = ["ssh"]
  },
  # {
  #   name                 = "db-service"
  #   ami                  = "ami-0f1e61a80c7ab943e"
  #   instance_type        = "t3.micro"
  #   volume               = 10
  #   is_public            = false
  #   subnet_name          = "private1"
  #   security_group_names = ["db-unique"]
  # }
]



# S3
# 사용하지 않으면: s3_buckets = {} 
s3_buckets = {
  "ktb21-load-test-cloud" = {
    bucket_name             = "cloud-infra"
    enable_website_hosting  = false          # Outputs 데이터를 웹에서 노출할 필요 없음
    enable_cors             = false          # 브라우저 기반 접근 불필요
    enable_public_access    = false          # 공개 접근 차단
    block_public_acls       = true           # 모든 Public ACL 차단
    ignore_public_acls      = true           # Public ACL 무시
    block_public_policy     = true           # Public 정책 차단
    restrict_public_buckets = true           # 모든 Public 접근 차단
    environment             = "development"
  },
  "ktb21-load-test-service" = {
    bucket_name             = "service-bucket"
    enable_website_hosting  = true
    enable_cors             = true
    enable_public_access    = true
    block_public_acls       = true
    ignore_public_acls      = true
    block_public_policy     = true
    restrict_public_buckets = true
    environment             = "development"
  }
}
