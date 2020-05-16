# DevOps Exercise:

1. Create a barebones dockerized application (in the language of your choice) with just one endpoint that returns "hello world" and run it as an Elastic Container Service on an ECS cluster in AWS. 

2. Send APM metrics of the docker application to the Datadog dashboard.

This problem can be solved in more than one way but you can go with a solution that you think is best. The most important part of this exercise is the self-evaluation of the solution. So please take the time to document the pros, cons, and improvements that can be made on top of your solution.

# Environment Details

1. AWS EC2 instance
2. AWS ECS cluster using Fargate  
3. AWS Container launch using Fargate
4. Datadog APM 

# Install Docker on EC2 instance

  - sudo yum update -y
  - sudo amazon-linux-extras install docker
  - sudo service docker start
  - sudo usermod -a -G docker ec2-user

exit and check docker version
  - docker info

# Clone hell-world repo 

  - git clone git@github.com:sg3629/hello-world.git

# Build and Test the hello-world docker application 

## Build
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

