#Source: https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/
#Used to Build AWS ECS Cluster

data "aws_availability_zones" "available_zones" {
  state = "available"
}

resource "aws_vpc" "default" {
  cidr_block = "10.32.0.0/16"
  tags = {
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "default"
    prod_yor_trace            = "e076fa0e-a661-4b41-ab60-3d99b4408784"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "public_sub"
    prod_yor_trace            = "4a350995-80f9-44b8-8a64-2648cc5b6501"
  }
}

#Private Subnet
resource "aws_subnet" "private_sub" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id            = aws_vpc.default.id
  tags = {
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "private_sub"
    prod_yor_trace            = "76bfb218-375b-4d8d-b683-b55a4eca3f90"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "internet_gateway"
    prod_yor_trace            = "b026b689-3a7b-4b95-b3f4-2372858db4a9"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "gateway_eip"
    prod_yor_trace            = "3f179fe8-db2f-4d50-80e5-34df1d16f766"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 2
  subnet_id     = element(aws_subnet.public_sub.*.id, count.index)
  allocation_id = element(aws_eip.gateway_eip.*.id, count.index)

  tags = {
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "nat_gateway"
    prod_yor_trace            = "43ff84fa-5c10-459f-9516-69ca257b370f"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "private_rt"
    prod_yor_trace            = "3057861b-2e68-43e8-89b8-bc28e280a992"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "lb_sg"
    prod_yor_trace            = "a15b9da8-8d1f-4b74-a32a-d3d5ed5ec750"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "default_lb"
    prod_yor_trace            = "77289477-3cd9-40d0-a12b-66430d2cfe3f"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "lb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.default.id
  target_type = "ip"

  tags = {
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "lb_target_group"
    prod_yor_trace            = "dbc66168-8a48-4639-9214-9c9f4c98c755"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "task_definition"
    prod_yor_trace            = "64d184e8-3641-4180-a0d0-b1804e83c8db"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "hello_world_task_sg"
    prod_yor_trace            = "9c0d1ec3-c9ee-417e-8c6d-10a41043d66f"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "main_ecs_cluster"
    prod_yor_trace            = "73cea8bd-2fb3-4d80-8294-9870999335b6"
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
    prod_git_commit           = "5c06ea5782a56edb27a5c5b726713d1392fb0ac8"
    prod_git_file             = "terraform/build_aws_ecs.tf"
    prod_git_last_modified_at = "2023-10-29 11:55:03"
    prod_git_last_modified_by = "JonHurtt@gmail.com"
    prod_git_modifiers        = "JonHurtt"
    prod_git_org              = "jonhurtt"
    prod_git_repo             = "secure-sdlc"
    prod_yor_name             = "hello_world_ecs_srvc"
    prod_yor_trace            = "890c6b9d-408b-4d7d-8aff-cf54f0bc551b"
  }
}

