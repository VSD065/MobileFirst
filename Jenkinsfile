pipeline {
    agent any

    environment {
        // Set your project ID and GCR repository
        PROJECT_ID = 'crack-atlas-430705-a1'
        IMAGE_NAME = 'gcr.io/crack-atlas-430705-a1/mobilefirstnew'
        GCR_URL = "gcr.io/${PROJECT_ID}/${IMAGE_NAME}"
        KUBE_CONFIG_PATH = '/root/.kube/config'
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
                    // sh "docker image build -t ${IMAGE_NAME}:latest ."
                    sh 'docker build -t  ${IMAGE_NAME} .'
                }
            }
        }
        stage ('Deploying on kubernetes') {
            script {
                    withEnv(["KUBECONFIG=${KUBE_CONFIG_PATH}"]) {
                        // Apply the Kubernetes deployment configuration
                        sh """
                        kubectl set image deployment/mobilefirst-deployment mobilefirst-container=${GCR_URL} --record
                        kubectl rollout status deployment/mobilefirst-deployment
                        """
                    }
            // steps {
            //     sh 'kubectl apply -f k8s/deployment.yaml'
            //     sh 'kubectl rollout restart deploy mobilefirst'
            // }
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
                    // sh "docker push ${GCR_URL}"
                    // sh "docker image push ${IMAGE_NAME}:latest"
                    // sh "docker image rm ${IMAGE_NAME}:latest"
                     sh 'docker push ${IMAGE_NAME}'
                    
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
