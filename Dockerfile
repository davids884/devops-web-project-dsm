# Usamos la imagen oficial de Tomcat (JDK 11)
FROM tomcat:9.0-jdk11-openjdk

# Borramos las apps por defecto para evitar conflictos
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos el archivo .war generado por Maven y lo nombramos ROOT.war
# Esto hace que tu web sea la principal y cargue en la raíz
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Exponemos el puerto estándar de Tomcat
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["catalina.sh", "run"]
