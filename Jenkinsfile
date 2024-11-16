pipeline {
    agent any

    environment {
        // Set your project ID and GCR repository
        PROJECT_ID = 'crack-atlas-430705-a1'
        IMAGE_NAME = 'mobilefirstnew'
        GCR_URL = "gcr.io/${PROJECT_ID}/${IMAGE_NAME}"
    }

    stages {
        stage('Clone Repository') {
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

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    // docker.build("${IMAGE_NAME}")
                    sh "docker image build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        // stage('Authenticate with GCR') {
        //     steps {
        //         script {
        //             // Authenticate with Google Cloud using Service Account credentials
        //             withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
        //                 sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
        //                 sh 'gcloud auth configure-docker'
        //             }
        //         }
        //     }
        // }
        stage('Authenticate with GCR') {
          steps {
            script {
             withCredentials([file(credentialsId: 'gcr-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                echo "Service account key is at ${GOOGLE_APPLICATION_CREDENTIALS}"  // Debugging line
                sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
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
