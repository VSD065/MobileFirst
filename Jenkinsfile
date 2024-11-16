pipeline {
    agent any

    environment {
        PROJECT_ID = 'crack-atlas-430705-a1'
        IMAGE_NAME = 'mobilefirstnew'
        GCR_URL = "gcr.io/${PROJECT_ID}/${IMAGE_NAME}"
        KUBE_CONFIG_PATH = '/home/jenkins/.kube/config'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    git(
                        credentialsId: 'cred4mobilefirst',
                        url: 'https://github.com/VSD065/MobileFirst.git',
                        branch: 'main'
                    )
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${GCR_URL}:latest ."
                }
            }
        }

        stage('Authenticate with GCR') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'gcr-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
                        sh 'gcloud auth configure-docker'
                    }
                }
            }
        }

        stage('Push Docker Image to GCR') {
            steps {
                script {
                    sh "docker push ${GCR_URL}:latest"
                }
            }
        }
        stage('Deploying on Kubernetes') {
          steps {
             script {
               sh """
               kubectl --kubeconfig=${KUBE_CONFIG_PATH} apply -f k8s/deployment.yaml
               kubectl --kubeconfig=${KUBE_CONFIG_PATH} rollout status mobilefirst
               """
        }
    }
}

        
}

    post {
        always {
            echo "Pipeline finished"
        }
    }
}
