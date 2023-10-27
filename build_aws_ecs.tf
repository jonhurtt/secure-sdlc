#Source: https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/
#Used to Build AWS ECS Cluster

data "aws_availability_zones" "available_zones" {
  state = "available"
}

resource "aws_vpc" "default" {
  cidr_block = "10.32.0.0/16"
  tags = {
    git_commit           = "0b0a1af661b08c9b522dc77eef3cdb5995637a7a"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 13:08:31"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "default"
    yor_trace            = "8b65693a-c7c0-4db2-b704-05664fc506ec"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "public_sub"
    yor_trace            = "b2a0a1ba-328c-4b9e-ab80-ceb808801776"
  }
}

#Private Subnet
resource "aws_subnet" "private_sub" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id            = aws_vpc.default.id
  tags = {
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "private_sub"
    yor_trace            = "06608f20-6996-4be1-91e4-a5f3556d548c"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "internet_gateway"
    yor_trace            = "c6e9fa94-cf5a-481a-ad0f-dda0afabe98f"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "gateway_eip"
    yor_trace            = "15763420-99a4-42a7-8955-c93cf5625af3"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 2
  subnet_id     = element(aws_subnet.public_sub.*.id, count.index)
  allocation_id = element(aws_eip.gateway_eip.*.id, count.index)
  tags = {
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "nat_gateway"
    yor_trace            = "1e1cbbfb-20a2-4e3f-9260-abe97706b6a4"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "private_rt"
    yor_trace            = "8a2bb891-0164-44fb-9cb1-507d157563e2"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "lb_sg"
    yor_trace            = "f2d8952d-d2ed-4d0c-a324-009645fb44b7"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "default_lb"
    yor_trace            = "d4631078-57f9-4c0f-a80f-9a6d0c361cbf"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "lb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.default.id
  target_type = "ip"
  tags = {
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "lb_target_group"
    yor_trace            = "d0586981-c3c7-4803-9191-dc9e938c47a0"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "task_definition"
    yor_trace            = "5f3edd0e-de68-4aa7-92ca-018339647aa7"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "hello_world_task_sg"
    yor_trace            = "01dee72b-c8b7-4bc8-a8b8-2defc3b9b2b9"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "main_ecs_cluster"
    yor_trace            = "8f19f617-f6bd-404b-9d4e-265bfc2570d9"
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
    git_commit           = "ff82a4c60f2b54d294e9730ab26e572649cb85aa"
    git_file             = "build_aws_ecs.tf"
    git_last_modified_at = "2023-10-26 18:24:37"
    git_last_modified_by = "JonHurtt@gmail.com"
    git_modifiers        = "JonHurtt"
    git_org              = "jonhurtt"
    git_repo             = "secure-sdlc"
    yor_name             = "hello_world_ecs_srvc"
    yor_trace            = "bf9a2d33-747e-45da-bb73-4e79f203f226"
  }
}

