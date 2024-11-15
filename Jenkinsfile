pipeline {
    agent any
    //     tools {
    //     maven 'Maven-3.8.7' 
    // }
     
    stages {
        stage('git clone') {
            steps {
             git credentialsId: 'cred4mobilefirst', url: 'https://github.com/VSD065/MobileFirst.git'
            }
        }
    }
}
