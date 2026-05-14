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
                echo 'Packaging con Maven...'
                sh 'mvn clean package'
            }
        }
        
        stage('Cleanup') {
            steps {
                echo 'Eliminando contenedor antiguo si existe...'
                // Borra SOLO este contenedor, permitiendo que el backend siga vivo
                sh 'docker rm -f devops-web-project-server || true'
            }
        }

        stage('Build Image') {
            steps {
                echo 'Construyendo imagen Docker...'
                sh 'docker build -t davids884/devops-web-project:v1 .'
            }
        }

        stage('Run Container') {
            steps {
                echo 'Lanzando contenedor en puerto 8081...'
                // Mapeamos el puerto 8081 de la VM al 8080 de Tomcat
                sh 'docker run -d --name devops-web-project-server -p 8081:8080 davids884/devops-web-project:v1'
            }
        }
    }
}
