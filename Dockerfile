FROM tomcat:11.0.0-jdk21-openjdk
# Dummy text to test 
COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
