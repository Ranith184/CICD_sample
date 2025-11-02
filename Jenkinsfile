pipeline {
    agent any
    tools{
        jdk 'jdk21'
        maven 'maven'
    }
    environment{
        SCANNER_HOME= tool 'sonar-qube'
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'master', changelog: false, poll: false, url: 'https://github.com/Ranith184/CICD_sample.git'
            }
        }
        
        stage('Compile') {
            steps {
                sh 'mvn clean compile'
                echo "build successfully"
            }
        }
        stage('SonarQube Analysis') {
            steps {
               sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.host.url=http://35.156.107.35:9000/ -Dsonar.login=squ_0ac3418bbd97e5ccd2a9e18a67392c1575aba3be -Dsonar.projectName=CICD_sample \
               -Dsonar.java.binaries=. \
               -Dsonar.projectKey=CICD_sample '''
            }
        }
        
    }
}
