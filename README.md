# Karate Demo Project

This project is a demo that tests E2E case with Karate Framework

## 🚀 Features

- **Karate Framework** >API Test
- **Trello API** > Integration
- **Docker** >Support
- **Maven** >Build
- **Java 11** >Runtime
- **E2E Test** >Test Scenario

## 📋 Requirements

### Docker  (Recommended)
- Docker Desktop
- Git

### Manual Setup
- Java 11+
- Maven 3.6+
- Git

## 🐳 Quick Start with Docker 

### 1. Clone the project
```bash
git clone https://github.com/ezginacar/karate-trello-e2e-demo.git
cd Karate-Demo
```

### 2. Run test with Docker
```bash
# Run
docker compose up --build karate-tests

# Build
docker build -t karate-e2e-demo .
docker run --rm karate-e2e-demo

# Other Maven commands
docker run --rm karate-e2e-demo mvn clean install
docker run --rm karate-e2e-demo mvn clean compile
docker run --rm karate-e2e-demo mvn dependency:tree
```

## 🔧 Manual Setup

### 1. Java 11 Installation
```bash
# macOS
brew install openjdk@11
export JAVA_HOME=/opt/homebrew/opt/openjdk@11

# Ubuntu/Debian
sudo apt-get install openjdk-11-jdk

# Windows
# Oracle JDK 11 download and setup
```

### 2. Maven Installation
```bash
# macOS
brew install maven

# Ubuntu/Debian
sudo apt-get install maven

# Windows
# Download the Maven binary and add the PATH
```

### 3. Run the projects
```bash
# Download the dependencies
mvn dependency:resolve

# Run tests
mvn clean test -DTest='TestRunner'
```

## 📁 Project Structure

```
Karate-K6-Demo/
├── src/
│   ├── test/
│   │   ├── java/
│   │   │   └── runner/
│   │   │       └── TestRunner.java
│   │   └── resources/
│   │       ├── features/
│   │       │   └── CaseStudy.feature
│   │       ├── karate-config.js
│   │       ├── header.js
│   │       ├── faker-helpers.js
│   │       ├── DataCleanup.js
│   │       └── logback-test.xml
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── pom.xml
└── README.md
```

## 🧪 Test Case

### E2E Trello Workflow
- **Organization** >Create
- **Board** >Create
- **List** >Create
- **Card** >Create and update
- **Resource cleanup**  (Automatic cleanup when the test case failed)

### Test Features
- ✅ **Random data generation** (JavaFaker)
- ✅ **Resource tracking** (Automatic cleanup)
- ✅ **Clean logging** (Clean output in console)
- ✅ **Error handling**
- ✅ **Docker support** (platform independent)
- ✅ **Parallel execution**  (support)

## 🔑 Configuration

### API Keys
Trello API keys> `src/test/resources/karate-config.js`;

```javascript
var config = {
    accessToken: 'your-access-token',
    apiKey: 'your-api-key',
    baseUrl: 'https://api.trello.com'
}
```

### Environment Variables
```bash
# Docker 
export TRELLO_API_KEY=your-api-key
export TRELLO_ACCESS_TOKEN=your-access-token

# Manual installation
export JAVA_HOME=/path/to/java11
export MAVEN_OPTS="-Xmx512m"
```

## 📊 Test Reports

- **HTML Report**: `target/karate-reports/karate-summary.html`
- **JSON Report**: `target/karate-reports/all-logs.log`
- **All Logs**: `target/karate-reports/karate-repors`




## 🚨 Note: It may take a long time because Maven dependencies will be downloaded on the first run.
