pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub')  // ID of DockerHub creds in Jenkins
        IMAGE_NAME = 'venkat834/2048'
        RENDER_HOOK = 'https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=dvgbaxhcX44r'
    }

    triggers {
        githubPush()  // Auto-trigger when a change is pushed to GitHub (e.g., in HTML)
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Venkat834/2048-game.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                echo 'Triggering Render Deployment...'
                sh "curl -X GET ${RENDER_HOOK}"
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
