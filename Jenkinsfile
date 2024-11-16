pipeline {
    agent any
    environment {
        GCR_REPO = 'gcr.io/crack-atlas-430705-a1/mobilefirst'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Authenticate with GCR') {
            steps {
                script {
                    // Authenticate with Google Cloud using the service account key
                    withCredentials([file(credentialsId: 'gcr-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                        sh 'gcloud auth configure-docker gcr.io --quiet'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $GCR_REPO .'
                }
            }
        }
        stage('Push to GCR') {
            steps {
                script {
                    // Push the Docker image to Google Container Registry
                    sh 'docker push $GCR_REPO'
                }
            }
        }
    }
}
