pipeline {
    agent {
        node {
            label 'dockerhost-build-server'
        }
    }
    tools {
        // Asegúrate de que en Jenkins (Tools) el nombre sea 'maven'
        maven 'maven'
    }
    stages {
        stage('Packaging') {
            steps {
                echo 'Packaging con Maven...'
                sh 'mvn clean package'
            }
        }
        stage('Cleanup Old Container') {
            steps {
                echo 'Limpiando contenedores antiguos...'
                // Borra el contenedor si ya existe para que no de error de nombre duplicado
                sh 'docker rm -f devops-web-project-server || true'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Construyendo la imagen Docker...'
                sh 'docker build -t davids884/devops-web-project:v1 .'
            }
        }
        stage('Run Docker Container') {
            steps {
                echo 'Arrancando el contenedor en el puerto 8081...'
                // Mapeamos el puerto 8081 externo al 8080 interno de Tomcat
                sh 'docker run -d --name devops-web-project-server -p 8081:8080 davids884/devops-web-project:v1'
            }
        }
    }
}
