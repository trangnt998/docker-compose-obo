FROM maven:3.8.2-openjdk-11 AS build
WORKDIR /build

COPY . .

RUN mvn clean install

#
# Package stage
#
FROM maven:openjdk
WORKDIR /obo-stadium-1.0

COPY --from=build /build/target/*.jar obo-stadium-1.0.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","obo-stadium-1.0.jar"]

CMD ["mvn", "spring-boot:run"]