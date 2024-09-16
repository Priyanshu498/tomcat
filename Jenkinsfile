pipeline {
    agent any

    environment {
        SSH_CREDENTIALS_ID = 'ubuntu'  // ID of the SSH credentials
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Priyanshu498/tomcat.git'
            }
        }           
   
        stage('Run Ansible Playbook') {
            steps {
                sshagent([SSH_CREDENTIALS_ID]) {
                    sh 'ansible-playbook -i assignmet_0n_tool/tomcat/tests/inventory assignmet_0n_tool/tomcat/tests/test.yml'
                }
            }
        }
    }

    post {
        success {
            echo 'Tomcat installed successfully!'
        }
        failure {
            echo 'Failed to install Tomcat.'
        }
    }
}

