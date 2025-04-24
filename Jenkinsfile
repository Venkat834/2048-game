pipeline {
    agent any

    environment {
        IMAGE_NAME = 'venkat834/2048'
        DOCKERHUB_USERNAME = credentials('venkat834') // Add this in Jenkins Credentials
        DOCKERHUB_PASSWORD = credentials('Venkat@834') // Add this in Jenkins Credentials
        RENDER_HOOK = 'https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=dvgbaxhcX44r'
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

        stage('Login & Push to Docker Hub') {
            steps {
                bat """
                echo Logging in to DockerHub...
                echo Venkat@834 | docker login -u venkat834 --password-stdin
                docker tag 2048 venkat834/2048
                docker push venkat834/2048
                """
            }
        }

        stage('Deploy to Render') {
            steps {
                echo '🚀 Triggering Render Deployment...'
                bat "curl -X GET 'https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=dvgbaxhcX44r'
    }"
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
