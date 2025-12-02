pipeline {

    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'ls -la' // Example command to list files
                sh "pwd"
                sh 'cd work_folder'
                sh 'nix-shell -p cowsay'
                sh 'cowsay "Hello, World!"'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // Add test steps here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add deployment steps here
            }
        }
    }
}