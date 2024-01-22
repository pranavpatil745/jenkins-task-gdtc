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
                    echo "Terraform action is --> ${Action}"
                    sh "terraform ${Action} --auto-approve"

                    
                }
            }
        }
    }
}