pipeline {
    agent any

    environment {
        // Set your project ID and GCR repository
        PROJECT_ID = 'crack-atlas-430705-a1'
        IMAGE_NAME = 'mobilefirst'
        GCR_URL = "gcr.io/${PROJECT_ID}/${IMAGE_NAME}"
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository where your Dockerfile is
                git 'https://github.com/VSD065/MobileFirst.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Authenticate with GCR') {
            steps {
                script {
                    // Authenticate with Google Cloud using Service Account credentials
                    withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                        sh 'gcloud auth configure-docker'
                    }
                }
            }
        }

        stage('Push Docker Image to GCR') {
            steps {
                script {
                    // Push the Docker image to Google Container Registry (GCR)
                    sh "docker push ${GCR_URL}"
                }
            }
        }

        stage('Deploy') {
            steps {
                // This is a placeholder for any deployment logic you might have
                // such as deploying to Kubernetes or any other platform
                echo "Deploying to GKE or any other environment"
            }
        }
    }

    post {
        always {
            // Cleanup tasks, if needed
            echo "Pipeline finished"
        }
    }
}
