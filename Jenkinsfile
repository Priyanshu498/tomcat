pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git 'https://github.com/Priyanshu498/tomcat.git'
            }
        }
        
        stage('Install Tomcat') {
            steps {
                // Execute the bash script with the specified Tomcat version
                sh './install_tomcat.sh 10.1.26'
            }
        }
    }
}
