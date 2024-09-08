pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git 'https://github.com/Priyanshu498/tomcat.git'
            }
        }
        
   
    stage('Playbook Execution') {
        // Set the PATH variable to include the location of ansible-playbook
        withEnv(["PATH+AN=/opt/homebrew/bin"]) {
            sh "ansible-playbook -i /Users/priyanshu/Apache-tom/assignmet_0n_tool/tomcat/tests/inventory /Users/priyanshu/Apache-tom/assignmet_0n_tool/tomcat/tests/test.yml"
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
