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
    }
}