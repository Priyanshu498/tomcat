pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Priyanshu498/tomcat.git'
            }
        }
        stage('Install Ansible') {
            steps {
                sh 'sudo apt update'
                sh 'sudo apt install -y ansible'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i assignmet_0n_tool/tomcat/tests/inventory playbook.yml'
            }
        }
    }

    post {
        always {
            echo 'Tomcat installation complete!'
        }
    }
}


