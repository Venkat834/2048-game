pipeline {
    agent any

    environment {
        IMAGE_NAME = 'venkat834/2048'
        RENDER_HOOK = 'https://api.render.com/deploy/srv-d03r09idbo4c738m1ge0?key=dvgbaxhcX44r'
        DOCKER_USERNAME = credentials('venkat834')   // Create in Jenkins (Username only)
        DOCKER_PASSWORD = credentials('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')   // Create in Jenkins (Password or token)
    }

    triggers {
        githubPush()  // Auto-trigger on GitHub push
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Venkat834/2048-game.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t 2048:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                bat """
                echo "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" | docker login -u "venkat834" --password-stdin
                docker push 2048:latest
                """
            }
        }

        stage('Deploy to Render') {
            steps {
                echo 'Triggering Render Deployment...'
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
