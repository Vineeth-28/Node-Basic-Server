pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/opt/homebrew/bin:${env.PATH}"
    }

    stages {
        stage('Code clone') {
            steps {
                echo 'Cloning Node-Basic-Server...'
                git branch: 'main', url: 'https://github.com/Vineeth-28/Node-Basic-Server.git'
                echo 'Code clone done.'
            }
        }

        stage('Build') {
            steps {
                echo 'Starting Docker build...'
                sh "docker build -t nodeserver ."
            }
        }

        stage('Deploy to Dockerhub') {
            steps {
                echo "Deploying to Dockerhub"
                withCredentials([usernamePassword(
                    credentialsId: "dockerHubCreds",
                    passwordVariable: "dockerHubPass",
                    usernameVariable: "dockerHubUser"
                )]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker tag nodeserver ${env.dockerHubUser}/nodeserver:latest"
                    sh "docker push ${env.dockerHubUser}/nodeserver:latest"
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running basic validations...'
                sh "docker images | grep nodeserver"
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application locally...'
                // Optional tip: Add 'docker rm -f node-app-instance || true' before this line to prevent "container name already in use" errors on re-runs.
                sh "docker run -d --name node-app-instance -p 3000:3000 nodeserver"
            }
        }
    }
}
