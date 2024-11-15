// pipeline {
//     agent any
//     environment {
//         GCR_REPO = 'gcr.io/crack-atlas-430705-a1/mobilefirst'
//     }
//     stages {
//         stage('Build') {
//             steps {
//                 script {
//                     // Build Docker Image
//                     sh 'docker build -t $GCR_REPO .'
//                 }
//             }
//         }
//         stage('Push to GCR') {
//             steps {
//                 script {
//                     // Log in to GCR (using the pre-configured gcloud helper)
//                     sh 'gcloud auth configure-docker'

//                     // Push Docker Image to GCR
//                     sh 'docker push $GCR_REPO'
//                 }
//             }
//         }
//     }
// }
pipeline {
    agent any
    environment {
        GCR_REPO = 'gcr.io/crack-atlas-430705-a1/mobilefirst'
        GOOGLE_APPLICATION_CREDENTIALS = '/home/vishalkey/crack-atlas-430705-a1-287fd89a355f.json' // Path to your service account JSON key
    }
    stages {
        stage('Authenticate with GCR') {
            steps {
                script {
                    // Ensure the service account is activated for gcloud
                    withCredentials([file(credentialsId: 'gcr-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh "gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS"
                        sh "gcloud auth configure-docker"
                    }
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    // Build Docker Image
                    sh 'docker build -t $GCR_REPO .'
                }
            }
        }
        stage('Push to GCR') {
            steps {
                script {
                    // Push Docker Image to GCR
                    sh 'docker push $GCR_REPO'
                }
            }
        }
    }
}


