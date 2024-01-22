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
                script {
                    echo "Terraform action is --> ${TERRAFORM_ACTION}"
                    sh "terraform ${TERRAFORM_ACTION} --auto-approve"

                    // Capture the ECR repository URI from Terraform output
                    REPOSITORY_URI = sh(script: 'terraform output -json ecr_repository_uri', returnStdout: true).trim()
                    env.REPOSITORY_URI = REPOSITORY_URI  // Set the environment variable for later use
                }
            }
        }
    }
}