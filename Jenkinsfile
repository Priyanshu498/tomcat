pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                // Checkout the code from your Git repository
                git url: 'https://github.com/Priyanshu498/tomcat.git'
               
                
            }
        }

        stage('Dryrun Playbook') {
            steps {
                // Use SSH credentials to run the dry run of the Ansible playbook
                withCredentials([sshUserPrivateKey(credentialsId: 'ubuntu', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                    sh '''
                    ansible-playbook -i tomcat/assignmet_0n_tool/tomcat/tests/inventory tomcat/assignmet_0n_tool/tomcat/tests/test.yml --check
                    '''
                }
            }
        }

        stage('Execute Playbook') {
            input {
                message "Do you want to perform apply?"
                ok "Yes"
            }
            steps {
                // Use SSH credentials to run the Ansible playbook
                withCredentials([sshUserPrivateKey(credentialsId: 'ubuntu', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                    sh '''
                    ansible-playbook -i tomcat/assignmet_0n_tool/tomcat/tests/inventory tomcat/assignmet_0n_tool/tomcat/tests/test.yml
                    '''
                }
            }
        }
    }
}



