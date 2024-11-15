pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                script {
                    // Explicitly define the branch to avoid conflicts
                    git(
                        credentialsId: 'cred4mobilefirst',
                        url: 'https://github.com/VSD065/MobileFirst.git',
                        branch: 'main' // Replace 'main' with 'master' if the default branch is master
                    )
                }
            }
        }
    }
}
