# DevOps exercise

1. Create a barebones dockerized application (in the language of your choice) with just one endpoint that returns "hello world" and run it as an Elastic Container Service on an ECS cluster in AWS. 

2. Send APM metrics of the docker application to the Datadog dashboard.

This problem can be solved in more than one way but you can go with a solution that you think is best. The most important part of this exercise is the self-evaluation of the solution. So please take the time to document the pros, cons, and improvements that can be made on top of your solution.

# Environment details

1. AWS EC2 instance
2. AWS ECS cluster using Fargate  
3. AWS Container launch using Fargate
4. Datadog APM 

# Install docker on EC2 instance

  - sudo yum update -y
  - sudo amazon-linux-extras install docker
  - sudo service docker start
  - sudo usermod -a -G docker ec2-user

exit and check docker version
  - docker info

# Clone hell-world repo 

  - git clone git@github.com:sg3629/hello-world.git

# Build, run and test the hello-world docker application - local

## Build and run
  - cd hello-world 
  - docker build -t flask-1:latest . 
  - docker run -t -i -d -p 5050:5050 flask-1
## Test
  - curl http://0.0.0.0:5050
  > hello world 

# Push docker images to AWS ECS image repository 

Authenticate to image repository using https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html#registry_auth 
 
  - aws ecr create-repository --repository-name hello-world-repository-4 --region us-east-1
  - docker tag flask-1 <ID>.dkr.ecr.us-east-1.amazonaws.com/hello-world-repository-4
  - docker push <ID>.dkr.ecr.us-east-1.amazonaws.com/hello-world-repository-4  

# Amazon ECS and Datadog Fargate integration 

Follow the guide: https://app.datadoghq.com/account/settings#integrations/aws-fargate 

# Setup, run and rest hello-world docker application - ECS 

  ## Setup and run
  - Create ECS cluster followed by Fargate 
  - Create Task definition with launch type Fargate 
  - Allocate required resources, roles, size
  - Add required containers for application and datadog-agent 
      - datadog-agent 
        - provide image and DD_API_key and ECS_FARGATE 
      - hello-world app
        - provide pushed image registry, ports (5050 and 8126), and docker labels 
  - Associate security groups as per required TCP ports 
  - Run task definition 
 
  ## Test 

  - curl http://54.162.112.237:5050 
  > hello world
