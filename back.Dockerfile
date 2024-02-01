FROM openjdk:21
COPY target/RecetasApp-v1.jar .
ENTRYPOINT ["java", "-jar","RecetasApp-v1.jar"]