pipeline {
    agent any
    environment {
        GCP_PROJECT_ID = 'crack-atlas-430705-a1'
        IMAGE_NAME = "gcr.io/${GCP_PROJECT_ID}/MobileFirst" // Replace `GCP_PROJECT_ID` with your project ID
    }
    triggers {
        pollSCM('* * * * *') // Poll SCM every minute for changes
    }
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
        stage('GCR Authentication') {
            steps {
                script {
                    // Authenticate with GCR using GCP credentials
                    sh '''
                    echo $GCR_CREDENTIALS > /home/vishalkey/crack-atlas-430705-a1-287fd89a355f.json
                    gcloud auth activate-service-account --key-file=/home/vishalkey/crack-atlas-430705-a1-287fd89a355f.json
                    gcloud config set project $GCP_PROJECT_ID
                    gcloud auth configure-docker
                    '''
                }
            }
        }
        stage('Docker Image Build & Push to GCR') {
            steps {
                script {
                    // Build and push the Docker image
                    sh '''
                    docker image build -t ${IMAGE_NAME}:latest .
                    docker image push ${IMAGE_NAME}:latest
                    docker image rm ${IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }
    post {
        always {
            cleanWs() // Clean up workspace after the pipeline
        }
        success {
            echo 'Pipeline executed successfully. Docker image pushed to GCR!'
        }
        failure {
            echo 'Pipeline execution failed. Check logs for more details.'
        }
    }
}
}

