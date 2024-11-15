pipeline {
    agent any
    environment {
        GCR_REPO = 'gcr.io/crack-atlas-430705-a1/mobilefirst'
    }
    stages {
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
                    // Log in to GCR (using the pre-configured gcloud helper)
                    sh 'gcloud auth configure-docker'

                    // Push Docker Image to GCR
                    sh 'docker push $GCR_REPO'
                }
            }
        }
    }
}
// pipeline {
//     agent any
//     environment {
//         GCR_REPO = 'gcr.io/crack-atlas-430705-a1/mobilefirst'
//     }
//     stages {
//         stage('Authenticate with GCR') {
//             steps {
//                 script {
//                     withCredentials([file(credentialsId: 'gcr-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
//                         sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
//                         sh 'gcloud auth configure-docker'
//                     }
//                 }
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     sh 'docker build -t $GCR_REPO .'
//                 }
//             }
//         }
//         stage('Push to GCR') {
//             steps {
//                 script {
//                     sh 'docker push $GCR_REPO'
//                 }
//             }
//         }
//     }
// }


