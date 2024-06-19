pipeline {
    agent any

    environment {
        BACKEND_REPO = 'https://github.com/Shivanandmetri/school-management-Backend.git'
        FRONTEND_REPO = 'https://github.com/Shivanandmetri/reactJavaProject.git'
        BACKEND_BRANCH = 'main'  // or the branch you want to build from
        FRONTEND_BRANCH = 'main'  // or the branch you want to build from
        DOCKER_IMAGE_FRONTEND = 'frontend' // The name of your Docker image
        DOCKER_TAG = 'latest' // The tag for your Docker image  
        DOCKER_IMAGE_BACKEND = 'backend' // The name of your Docker image
        REGISTRY_CREDENTIALS = 'docker-hub-credentials' // ID of the credentials in Jenkins
        DOCKER_REGISTRY_URL = '' // Docker registry URL, leave empty for Docker Hub
    }

    stages {
        stage('Checkout Backend') {
            steps {
                git branch: "${env.BACKEND_BRANCH}", url: "${env.BACKEND_REPO}"
            }
        }
 
        stage('Build Backend') {
            steps {
                bat 'mvnw.cmd clean package || mvn clean package'
            }
        }

        stage('Build Docker Backend Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${env.DOCKER_IMAGE_BACKEND}:${env.DOCKER_TAG}")
                }
            }
        }

        stage('Run Docker Backend Container') {
            steps {
                script {
                    // Stop and remove any existing container if it exists
                    bat '''
                    docker stop backend-container || exit 0
                    docker rm backend-container || exit 0
                    '''

                    // Run the Docker container
                    bat "docker run -d --name backend-container -p 8080:8080 ${env.DOCKER_IMAGE_BACKEND}:${env.DOCKER_TAG}"
                }
            }
        }

        stage('Checkout Frontend') {
            steps {
                dir('frontend') {
                    git branch: "${env.FRONTEND_BRANCH}", url: "${env.FRONTEND_REPO}"
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }

        stage('Build Docker Frontend Image') {
            steps {
                script {
                    dir('frontend') {
                        // Build the Docker image
                        docker.build("${env.DOCKER_IMAGE_FRONTEND}:${env.DOCKER_TAG}")
                    }
                }
            }
        }

        stage('Run Docker Frontend Container') {
            steps {
                script {
                    // Stop and remove any existing container if it exists
                    bat '''
                    docker stop frontend-container || exit 0
                    docker rm frontend-container || exit 0
                    '''

                    // Run the Docker container
                    bat "docker run -d --name frontend-container -p 3000:3000 ${env.DOCKER_IMAGE_FRONTEND}:${env.DOCKER_TAG}"
                }
            }
        }
    }
}
