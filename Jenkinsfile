pipeline {
    agent {
        node {
            label 'dockerhost-build-server'
        }
    }
    tools {
        // Se cambia 'maven-3.9.6' por 'maven' que es el estándar en Jenkins
        maven 'maven' 
    }
    stages {
        stage('Packaging') {
            steps {
                echo 'Packaging..'
                sh 'mvn clean package'
            }
        }
        stage('Copying war file') {
            steps {
                echo 'Copying war file..'
                // Usamos cp en lugar de mv para evitar errores si el archivo está bloqueado
                sh 'cp target/*.war .'
            }
        }
        stage('cleanup') {
            steps {
                // Borramos el contenedor anterior si existe para que no de error de "nombre duplicado"
                sh 'docker rm -f devops-web-project-server || true'
                sh 'docker system prune -f'
            }
        }
        stage('build image') {
            steps {
                sh 'docker build -t davids884/devops-web-project:v1 --label devops-web-project-server .'
            }
        }
        stage('run container') {
            steps {
                // IMPORTANTE: Mantenemos puerto 8081 para no chocar con el Tomcat manual (8080)
                sh 'docker run -d --name devops-web-project-server --label devops-web-project-server -p 8081:8080 davids884/devops-web-project:v1'
            }
        }
    }
}
