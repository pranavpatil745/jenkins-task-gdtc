pipeline {
    agent any
     environment {
        ECR_REPO_URL = sh(script: 'terraform output ecr_repository_url', returnStdout: true).trim()
    }
    stages {
        stage('Checkout') {
            steps {
                  checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'githubtoken', url: 'https://github.com/pranavpatil745/Jenkins-docker-task.git']])
            }
        }
        stage ("init") {
            steps {
                sh("terraform init")
            }
        }
        stage("plan") {
            steps{
                sh("terraform plan")
            }
        }
        stage ("action") {
            steps {
                  echo "Terraform action is --> ${action}"
                  sh ("terraform ${action} --auto-approve")

            }
        }
        stage("build") { 

            steps { 

                sh "docker build -t my-app ." 

            } 

        } 
        stage("Logging") { 

             steps { 

               withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS-Credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]])
             {
            script {
                echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
                echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
                sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 948427039490.dkr.ecr.ap-south-1.amazonaws.com" 

                // Access ECR_REPO_URL directly from the environment
                // echo "ECR Repository URL: ${ECR_REPO_URL}"

                // // Use ECR_REPO_URL in specific steps
                // sh "docker build -t ${ECR_REPO_URL}:latest ."
                   }
                }
            }
        }
       stage('PushImage') { 

               steps{   
               script { 
                   sh "docker tag my-app:latest 948427039490.dkr.ecr.ap-south-1.amazonaws.com/lambdaxjenkins:latest" 
                   sh "docker push 948427039490.dkr.ecr.ap-south-1.amazonaws.com/lambdaxjenkins:latest" 
                 } 
            } 
         } 
    }   
}