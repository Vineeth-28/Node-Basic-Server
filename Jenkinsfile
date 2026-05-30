pipeline {
    agent any

    environment {
        // Automatically injects the Mac Docker Desktop CLI path globally for all stages
        PATH = "/usr/local/bin:/opt/homebrew/bin:${env.PATH}"
    }

    stages {
        stage('Code clone') {
            steps {
                echo 'Cloning Node-Basic-Server...'
                // Using the specific repo seen in your log environment
                git branch: 'main', url: 'https://github.com/Vineeth-28/Node-Basic-Server.git'
                echo 'Code clone done.'
            }
        }

        stage('Build') {
            steps {
                echo 'Starting Docker build...'
                // Executes inside the directory containing your Node.js Dockerfile
                sh "docker build -t myapp ."
            }
        }

        stage('Test') {
            steps {
                echo 'Running basic validations...'
                // Verifies that your container image exists locally on your Mac
                sh "docker images | grep myapp"
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application locally...'
                // Runs the container detached, mapping a local port if required
                sh "docker run -d --name node-app-instance -p 3000:3000 myapp"
            }
        }
    }
}
