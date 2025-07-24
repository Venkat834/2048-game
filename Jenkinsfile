pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'venkat834/2048'
        BRANCH = 'master'
        RENDER_DEPLOY_HOOK_URL =  'https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=wUdfKLNjbPs'

    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: "master", url: 'https://github.com/Venkat834/2048-game.git'

            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build --no-cache -t venkat834/2048:latest .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                   // bat 'docker rm -f venkat834/2048 || true'  // Stop and remove old container if exists
                    bat 'docker run -d -p 80:80 venkat834/2048:latest'  // Run new container
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'venkat834', passwordVariable: 'Venkat@834')]) {
                    script {
                        // Docker login using Jenkins credentials securely
                        bat '''
                            echo Venkat@834 | docker login -u venkat834 --password-stdin
                            docker tag 2048:latest venkat834/2048:latest
                            docker push venkat834/2048:latest
                        '''
                    }
                }
            }
        }

        stage('Deploy to Render') {
            when {
                expression { return env.RENDER_DEPLOY_HOOK_URL != null }
            }
            steps {
                echo 'Triggering Render Deploy via Webhook...'
                bat  '''
                     curl -X POST "https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=wUdfKLNjbPs"
                '''
              echo "Deployment Success."
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
