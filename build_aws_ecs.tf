#Source: https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/
#Used to Build AWS ECS Cluster

data "aws_availability_zones" "available_zones" {
  state = "available"
}

resource "aws_vpc" "default" {
  cidr_block = "10.32.0.0/16"
  tags = {
    prod_git_commit           = "0b0a1af661b08c9b522dc77eef3cdb5995637a7a"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 13:08:31"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "default"
    prod_yor_trace            = "2db9b870-d524-443f-a884-3d54caca37ac"
  }
}

#Public Subnet
resource "aws_subnet" "public_sub" {
  count                   = 2
  cidr_block              = cidrsubnet(aws_vpc.default.cidr_block, 8, 2 + count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id                  = aws_vpc.default.id
  map_public_ip_on_launch = true
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "public_sub"
    prod_yor_trace            = "d9fe1fbe-c293-40b5-96e9-868b30c6521e"
  }
}

#Private Subnet
resource "aws_subnet" "private_sub" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id            = aws_vpc.default.id
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "private_sub"
    prod_yor_trace            = "68574365-a702-46f4-a27d-811be10017a2"
  }
}

/*These six resources handle networking and communication to and from the internet outside of the VPC. 
The internet gateway, for example, is what allows communication between the VPC and the internet at all. 
The NAT gateway allows resources within the VPC to communicate with the internet but will prevent communication
to the VPC from outside sources. That is all tied together with the route table association, where the 
private route table that includes the NAT gateway is added to the private subnets defined earlier. 
Security groups will need to be added next to allow or reject traffic in a more fine-grained way both 
from the load balancer and the application service*/

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.default.id

  tags = {
    prod_git_commit           = "24d88e46dca8e711600eaaa3731cc64d69edcb0a"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-27 14:08:00"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "internet_gateway"
    prod_yor_trace            = "ad29062a-7e4f-4280-883e-f2b379000540"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_eip" "gateway_eip" {
  count      = 2
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "gateway_eip"
    prod_yor_trace            = "813c3298-a570-4889-8ef4-a81e0d08a49d"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 2
  subnet_id     = element(aws_subnet.public_sub.*.id, count.index)
  allocation_id = element(aws_eip.gateway_eip.*.id, count.index)

  tags = {
    prod_git_commit           = "24d88e46dca8e711600eaaa3731cc64d69edcb0a"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-27 14:08:00"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "nat_gateway"
    prod_yor_trace            = "fe969f21-3c77-4b25-acee-622dbaa660ad"
  }
}

resource "aws_route_table" "private_rt" {
  count  = 2
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "private_rt"
    prod_yor_trace            = "12d953a6-f795-4e16-a13b-11a2df7d271c"
  }
}

resource "aws_route_table_association" "private_rta" {
  count          = 2
  subnet_id      = element(aws_subnet.private_sub.*.id, count.index)
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}

/*
The load balancer’s security group will only allow traffic to the load balancer on port 80, as defined 
by the ingress block within the resource block. Traffic from the load balancer will be allowed to 
anywhere on any port with any protocol with the settings in the egress block.
*/
resource "aws_security_group" "lb_sg" {
  name   = "alb-security-group"
  vpc_id = aws_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "lb_sg"
    prod_yor_trace            = "566b9b33-e9f8-4467-886a-f1783ccf6fa6"
  }
}

/*
The first block defines the load balancer itself and attaches it to the public subnet 
in each availability zone with the load balancer security group. 
*/

resource "aws_lb" "default_lb" {
  name            = "aws-loadbalancer"
  subnets         = aws_subnet.public_sub.*.id
  security_groups = [aws_security_group.lb_sg.id]
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "default_lb"
    prod_yor_trace            = "bb48a364-cadc-48a9-bd1c-dd03aa3df4ab"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "lb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.default.id
  target_type = "ip"

  tags = {
    prod_git_commit           = "24d88e46dca8e711600eaaa3731cc64d69edcb0a"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-27 14:08:00"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "lb_target_group"
    prod_yor_trace            = "913590e9-d4da-4e20-86b3-89fc7c9f494e"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.default_lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.id
    type             = "forward"
  }
}

/*
The task definition defines how the hello world application should be run. 
This is where it’s specified that the platform will be Fargate rather than EC2, 
so that managing EC2 instances isn’t required. This means that CPU and memory 
for the running task should be specified. The image used is a simple API that 
returns “Hello World!” and is available as a public Docker image. The Docker 
container exposes the API on port 3000, so that’s specified as the host and 
container ports. The network mode is set to “awsvpc”, which tells AWS that 
an elastic network interface and a private IP address should be assigned to 
the task when it runs.
*/

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "hello-world-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "hello-world-app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
DEFINITION
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "task_definition"
    prod_yor_trace            = "84df1911-4f34-47fd-99a0-0fad1eb89e8e"
  }
}

/*
The security group for the application task specifies that it should be added to the 
default VPC and only allow traffic over TCP to port 3000 of the application. The ingress 
settings also include the security group of the load balancer as that will allow traffic 
from the network interfaces that are used with that security group. It allows all 
outbound traffic of any protocol as seen in the egress settings.
*/
resource "aws_security_group" "hello_world_task_sg" {
  name   = "task-security-group"
  vpc_id = aws_vpc.default.id

  ingress {
    protocol        = "tcp"
    from_port       = 3000
    to_port         = 3000
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    prod_git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-26 18:24:37"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "hello_world_task_sg"
    prod_yor_trace            = "c7834170-cb6d-4728-8cf8-54887ad826e3"
  }
}

/*
The ECS service specifies how many tasks of the application should be run 
with the task_definition and desired_count properties within the cluster. 
The launch type is Fargate so that no EC2 instance management is required. 
The tasks will run in the private subnet as specified in the network_configuration 
block and will be reachable from the outside world through the load balancer 
as defined in the load_balancer block. Finally, the service shouldn’t be created 
until the load balancer has been, so the load balancer listener is included 
in the depends_on array.
*/

resource "aws_ecs_cluster" "main_ecs_cluster" {
  name = "secure-sdlc-ecs"

  tags = {
    prod_git_commit           = "24d88e46dca8e711600eaaa3731cc64d69edcb0a"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-27 14:08:00"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "main_ecs_cluster"
    prod_yor_trace            = "884e437a-86af-4d14-9bd5-95cc4361a32d"
  }
}

resource "aws_ecs_service" "hello_world_ecs_srvc" {
  name            = "secure-sdlc-ecs-service"
  cluster         = aws_ecs_cluster.main_ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.hello_world_task_sg.id]
    subnets         = aws_subnet.private_sub.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.id
    container_name   = "hello-world-app"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.lb_listener]

  tags = {
    prod_git_commit           = "24d88e46dca8e711600eaaa3731cc64d69edcb0a"
    prod_git_file             = "build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-27 14:08:00"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "hello_world_ecs_srvc"
    prod_yor_trace            = "fa6eff87-0264-4f48-9350-2e68f1252646"
  }
}

