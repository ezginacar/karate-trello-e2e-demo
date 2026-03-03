
# 🧪 Karate Trello E2E Automation Demo

Enterprise-style End-to-End API automation project built with Karate Framework.
This project demonstrates Trello API integration, Dockerized execution, secure secret management, and resource lifecycle cleanup.

---

## 🚀 Tech Stack

- Karate Framework (API Test Automation)
- Trello API (Integration)
- Java 11 (Runtime)
- Maven (Build Tool)
- Docker (Containerized Execution)
- n8n (Optional Workflow Orchestration)

---

## 🧪 Test Scenario (E2E Lifecycle)

The project validates a complete Trello resource lifecycle:

Organization → Board → List → Card  
                ↓  
            Update Card  
                ↓  
        Cleanup (Reverse Order)

Cleanup order:
Card → List (Archive) → Board → Organization

Cleanup can be handled either directly in Karate or orchestrated via n8n webhook.

---

## 📁 Project Structure

karate-trello-e2e-demo/
├── src/
│   └── test/
│       ├── java/
│       │   └── runner/
│       │       └── TestRunner.java
│       └── resources/
│           ├── features/
│           ├── config/
│           ├── helpers/
│           ├── karate-config.js
│           └── logback-test.xml
├── Dockerfile
├── docker-compose.yml
├── pom.xml
└── README.md
---

## 🔐 Secret Management

No API keys are stored in the repository.

Secrets are injected via environment variables:

### macOS / Linux

export TRELLO_API_KEY=your-api-key  
export TRELLO_ACCESS_TOKEN=your-access-token

### Windows (PowerShell)

setx TRELLO_API_KEY "your-api-key"  
setx TRELLO_ACCESS_TOKEN "your-access-token"

Karate reads them via environment:

```javascript
accessToken: karate.properties['TRELLO_ACCESS_TOKEN'] 
  || java.lang.System.getenv('TRELLO_ACCESS_TOKEN'),

apiKey: karate.properties['TRELLO_API_KEY'] 
  || java.lang.System.getenv('TRELLO_API_KEY')
```

---

## 🐳 Run with Docker (Recommended)

### 1. Clone Repository

git clone https://github.com/ezginacar/karate-trello-e2e-demo.git  
cd karate-trello-e2e-demo

### 2. Run Tests

docker compose up --build karate-tests

Or:

docker compose run --rm karate-tests mvn clean test

---

## 🛠 Manual Setup

### Requirements

- Java 11+
- Maven 3.6+

### Run Tests

mvn clean test

---

## 📊 Test Reports

After execution:

HTML Report:  
target/karate-reports/karate-summary.html

Open this file in your browser to see detailed execution results.

---

## 🧠 Engineering Concepts Demonstrated

- End-to-End API lifecycle testing
- Dynamic test data generation
- Secure secret handling
- Reverse-order cleanup strategy
- Modular feature structure
- Dockerized execution
- Optional external orchestration (n8n)

---

## ⚠️ First Run Notice

The first execution may take longer because Maven dependencies will be downloaded.
