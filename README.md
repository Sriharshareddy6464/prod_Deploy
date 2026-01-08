# ProdDeploy – Production CI/CD Pipeline with AWS, Docker, Nginx & SSL

## Overview
ProdDeploy is a production-grade deployment pipeline that automatically builds and deploys a Dockerized FastAPI application to an AWS EC2 instance using GitHub Actions. The application is fronted by Nginx as a reverse proxy and secured with HTTPS using Let’s Encrypt SSL certificates. A custom domain is configured via GoDaddy DNS.

This project demonstrates real-world DevOps practices including CI/CD automation, reverse proxy configuration, SSL termination, and cloud infrastructure management.

---

## Architecture

User  
→ Domain (adapalasriharshareddy.online)  
→ DNS (GoDaddy)  
→ AWS EC2 Public IP  
→ Nginx (Reverse Proxy + SSL Termination)  
→ Docker Container (FastAPI on port 8000)

---

## Tech Stack

- **Cloud:** AWS EC2 (Ubuntu)
- **Web Server / Reverse Proxy:** Nginx
- **Containerization:** Docker
- **Backend:** FastAPI (Python)
- **CI/CD:** GitHub Actions
- **SSL:** Let’s Encrypt (Certbot)
- **Domain & DNS:** GoDaddy
- **Version Control:** Git & GitHub

---

## End-to-End Flow

1. Developer pushes code to GitHub repository.
2. GitHub Actions pipeline is triggered automatically.
3. Pipeline connects to EC2 via SSH.
4. Existing container is stopped and removed.
5. New Docker image is built.
6. New container is started.
7. Nginx routes HTTPS traffic to the container.
8. User accesses the application via custom domain.

---

## CI/CD Pipeline

The pipeline is implemented using GitHub Actions and performs the following steps:

- Checkout repository code
- Configure SSH access to EC2
- Build Docker image on the server
- Stop and remove existing container
- Run new container with updated code

This enables zero-manual-intervention deployment on every push to the main branch.

---

## Nginx & SSL Setup

Nginx is configured as a reverse proxy:

- Listens on port 80 and redirects traffic to HTTPS
- Listens on port 443 with SSL enabled
- Forwards traffic to FastAPI running on `127.0.0.1:8000`

SSL certificates are generated and managed using Certbot (Let’s Encrypt).

---

## Deployment

The application is deployed on an AWS EC2 instance with:

- Docker installed
- Nginx installed and configured
- Ports 80 and 443 opened via Security Groups
- SSH access restricted for administration

All deployments are automated via CI/CD.

---

## Security Considerations

- SSH access is restricted using key-based authentication.
- SSL encryption is enforced for all traffic.
- Nginx handles public traffic; application is not directly exposed.
- AWS Security Groups control inbound access.

---

## How to Test

- Visit: `https://adapalasriharshareddy.online`
- Health check endpoint returns:
  ```json
  { "status": "ProdDeploy API is LIVE from CI/CD" }
