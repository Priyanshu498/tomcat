pipeline {
    agent any

    environment {
        TOMCAT_VERSION = "9.0.93" // Specify the Tomcat version here
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the Git repository
                git url: 'https://github.com/Priyanshu498/tomcat.git', branch: 'main'
            }
        }

        stage('Set Permissions') {
            steps {
                // Make the script executable
                sh 'chmod +x install_tomcat.sh'
            }
        }

        stage('Install Tomcat') {
            steps {
                // Run the Tomcat installation script
                sh "./install_tomcat.sh ${env.TOMCAT_VERSION}"
            }
        }
    }

    post {
        success {
            echo 'Tomcat installation was successful!'
        }

        failure {
            echo 'Tomcat installation failed.'
        }

        always {
            cleanWs() // Clean the workspace
        }
    }
}
