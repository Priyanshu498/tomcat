pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Git repository se code checkout karenge
                git branch: 'main', url: 'https://github.com/Priyanshu498/tomcat.git'
            }
        }
        stage('Install Ansible') {
            steps {
                // Ubuntu par Ansible install karenge
                sh 'sudo apt update'
                sh 'sudo apt install -y ansible'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                // Ansible Playbook run karenge jo Tomcat ko install karega
                sh 'ansible-playbook -i inventory playbook.yml'
            }
        }
    }

    post {
        always {
            // After execution cleanup ya report generate karenge
            echo 'Tomcat installation complete!'
        }
    }
}


