pipeline {
    agent any
 
    stages {
        stage('Checkout') {
            steps {
                  checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GithubCredentials', url: 'https://github.com/pranavpatil745/jenkins-task.git']])
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
		  ECR_REPOSITORY_URI = sh(script: 'terraform output -json ecr_repository_uri', returnStdout: true).trim()
            }
        }
    }
}