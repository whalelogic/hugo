---
date: "2025-11-16T14:10:13-05:00"
author: "Keith Thomson"
categories:
  - "Web Development"
description: "A comprehensive guide to deploying Express applications on Ubuntu using Docker, Nginx as a reverse proxy, and HTTPS with Certbot for secure web application deployment."
tags:
  - "docker"
  - "https"
  - "devops"
  - "http"
title: "🔐 Deploy an Express App with Docker, Nginx, and HTTPS"
---

# How to Deploy Your Express App with Docker, Nginx, and HTTPS (Ubuntu)

> This guide walks you through deploying your Express application on an Ubuntu Droplet, using the provided Dockerfile.

We will use Nginx as a reverse proxy to handle HTTPS (via Certbot) and pass traffic to your app running in Docker.

## Prerequisites

1. **Droplet:** A running Ubuntu Droplet.

2. **Domain:** A domain name (e.g., your-domain.com) with an A record pointing to your Droplet's IP address.

3. **Application Code:** Your Express app's source code should be on the Droplet, most likely cloned from a Git repository.

## Step 1: Install and Configure dependencies

- Install Nginx, Docker, and Certbot
- Log in to your Droplet as root or a user with sudo privileges.

### 1. Update your package lists

```bash
sudo apt-get update
```

### 2. Install Nginx

```bash
sudo apt-get install nginx -y
```

### 3. Install Docker

Ubuntu's default 'docker.io' package is often fine, but installing from the official Docker repo is recommended)

```bash
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# 4. Install Certbot and the Nginx plugin
sudo apt-get install certbot python3-certbot-nginx -y

# 5. Start and enable the services
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl start nginx
sudo systemctl enable nginx
```


## Step 2: Build and Run Your Docker App

**Navigate to your app's code:**

### Example:

```bash
git clone https://github.com/your-repo/my-app.git my-express-app

cd path/to/my-app
```

### Build the Docker image:

(This uses the app/Dockerfile provided.)

```bash
docker build -t my-express-app .
```

### Run the container:

This command runs your app in the background, ensures it restarts, and exclusively binds it to `localhost:3000.`

> This means it's not accessible from the public internet; only **Nginx** on the Droplet can talk to it.

### Run the container we built

```bash
docker run \
  -d \
  --restart always \
  --name express-app \
  -p 127.0.0.1:3000:3000 \
  my-express-app
```

## Step 3: Configure Nginx

This is the key difference from the Fedora guide.

Copy the Nginx Config:
Save the your-domain.com.conf file (which I generated for you) to your Droplet.

Move it to the sites-available folder:
(Remember to replace your-domain.com in the filename with your actual domain.)

---

```bash
sudo cp /path/to/your-domain.com.conf /etc/nginx/sites-available/your-domain.com
```

- Enable the site by creating a symbolic link:
- **This links your config into the 'sites-enabled' directory**
  
  ```bash
  sudo ln -s /etc/nginx/sites-available/your-domain.com /etc/nginx/sites-enabled/
  ```

### (Recommended) Remove the default Nginx config

```bash
sudo rm /etc/nginx/sites-enabled/default
```

## Test and Restart Nginx

Test the config for syntax errors

```bash
sudo nginx -t
```

### If the test is successful, restart Nginx

```bash
sudo systemctl restart nginx
```

At this point, if you visit `http://your-domain.com`, you should see your Express app (without HTTPS).
## Step 4: Enable HTTPS with Certbot

This step is the same as before. Certbot knows how to find your Ubuntu Nginx config.

### Run **Certbot:**

### **This command will guide you through a few prompts**

```bash
sudo certbot --nginx
```

- It will show a list of domains from your Nginx configs. Select your domain.

- It will ask if you want to redirect HTTP traffic to HTTPS. Select the "Redirect" option. This is highly recommended.

- **Restart Nginx (if needed):**

Certbot usually reloads Nginx, but if not, run:

```bash
sudo systemctl restart nginx
```

## You're Done!

Visit `https://your-domain.com.` You should see your Express app running with a valid SSL certificate. Certbot also sets up a systemd timer (or cron job) to auto-renew your certificate.
