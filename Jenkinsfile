pipeline {
    agent {
        node {
            label 'dockerhost-build-server'
        }
    }
    tools {
        maven 'maven'
    }
    stages {
        stage('Packaging') {
            steps {
                echo 'Packaging..'
                sh 'mvn clean package'
            }
        }
        
        // --- AQUÍ VA LA PARTE DE LIMPIEZA ---
        stage('Cleanup') {
            steps {
                echo 'Cleaning up old container...'
                sh 'docker rm -f devops-web-project-server || true'
            }
        }

        stage('build image') {
            steps {
                echo 'Building image..'
                // Usamos el tag v1 y tu usuario
                sh 'docker build -t davids884/devops-web-project:v1 .'
            }
        }

        stage('run container') {
            steps {
                echo 'Running container on port 8081..'
                // Mapeo 8081 -> 8080. El nombre coincide con el del Cleanup
                sh 'docker run -d --name devops-web-project-server -p 8081:8080 davids884/devops-web-project:v1'
            }
        }
    }
}
