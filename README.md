# Maven + Java 17 + Google Cloud SDK Docker Image

A ready-to-use Docker image for CI/CD pipelines including:

- Maven
- OpenJDK 17
- Google Cloud SDK (gcloud)
- App Engine Java component
- Python 3

Designed to avoid installing dependencies on every pipeline run.

---

## 📦 Included Tools

| Tool | Version |
|------|---------|
| Maven | from base image |
| Java | OpenJDK 17 |
| Google Cloud SDK | installed |
| App Engine Java | installed |
| Python | 3.x |

---

## 🐳 Base Image
maven:3.8.4-openjdk-17-slim

---


## 🚀 Usage

### Pull image

```bash
docker pull hasansahinnn/maven-java-17-gcloud:latest
