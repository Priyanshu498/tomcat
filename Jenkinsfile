pipeline {
    agent any

    environment {
        ANSIBLE_VERSION = '2.9.6' // Ansible version
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository
                git branch: 'master', url: 'https://github.com/Priyanshu498/tomcat.git'
            }
        }

        stage('Install Ansible') {
            steps {
                // Install Ansible (for Ubuntu)
                sh '''
                sudo apt update
                sudo apt install -y ansible
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                // Run the Ansible role to install Tomcat
                sh '''
                ansible-playbook -i inventory setup.yml
                '''
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
