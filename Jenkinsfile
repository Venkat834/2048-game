pipeline {
    agent any

    environment {
        IMAGE_NAME = 'venkat834/2048'
        RENDER_HOOK = 'https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=dvgbaxhcX44r'
        DOCKER_CREDENTIALS_ID = 'dockerhub' // Set this ID in Jenkins credentials
    }

    triggers {
        githubPush()  // Trigger pipeline on GitHub push
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Venkat834/2048-game.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t 2048 ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 2048) {
                        docker.image("2048").push()
                    }
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                echo '🚀 Triggering Render Deployment...'
                bat "curl -X GET https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=dvgbaxhcX44r"
            }
        }
    }

    post {
        success {
            echo '✅ CI/CD Pipeline executed successfully.'
        }
        failure {
            echo '❌ CI/CD Pipeline failed. Check logs for details.'
        }
    }
}
