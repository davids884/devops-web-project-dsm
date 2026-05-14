# Usamos una imagen ligera de Tomcat con Java 11
FROM tomcat:9.0-jdk11-openjdk

# Borramos las aplicaciones de ejemplo que trae Tomcat por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos el archivo .war que genera Maven
# Lo renombramos a ROOT.war para que la web cargue directamente en la IP
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Exponemos el puerto interno de Tomcat
EXPOSE 8080

# Comando para arrancar Tomcat
CMD ["catalina.sh", "run"]
