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
                        sh 'gcloud auth configure-docker gcr.io'
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
                    // Explicitly login to GCR
                    sh 'gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://gcr.io'
                    sh 'docker push $GCR_REPO'
                }
            }
        }
    }
}
