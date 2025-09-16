FROM maven:3.9.9-eclipse-temurin-11
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY . .
CMD ["sh", "-c", "mvn clean test -Dtest=TestRunner -DTRELLO_ACCESS_TOKEN=$TRELLO_ACCESS_TOKEN -DTRELLO_API_KEY=$TRELLO_API_KEY"]