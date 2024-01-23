pipeline {
    agent any
     environment {
         ECR_REPOSITORY_URI = sh(script: 'terraform output -json ecr_repository_uri', returnStdout: true).trim()
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
    }
}