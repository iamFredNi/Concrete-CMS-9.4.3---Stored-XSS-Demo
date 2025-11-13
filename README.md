# Concrete-CMS-9.4.3---Stored-XSS-Demo

This repository provides a pre-configured Docker environment for running Concrete CMS 9.4.3 to demonstrate and analyze a Stored Cross-Site Scripting (XSS) vulnerability.

## Quick Start

1. 
```bash
cd concretecsm
docker compose build --no-cache
docker compose up
```

This will start:
- web → PHP 8.2 + Apache + Concrete CMS on port 8080
- db → MySQL 8.0
- phpmyadmin → web interface on port 8081 (optional for this test)

2. Access the web app

Go to http://localhost:8080 , you should see the Concrete CMS installation screen.

When prompted, use the following database credentials as specified in the docker-compose.yaml file:

- Database Server: db
- Database Name: concretecms
- Database Username: concrete
- Database Password: concrete
- Site Name	: e.g. Concrete XSS Demo
- Admin Email: e.g admin@example.com
- Admin Password: admin123 (or your own)
- Starting Point: Elemental Full (recommended)

3. Access Admin Dashboard

Once installation is complete, log in at: http://localhost:8080/index.php/login
Use the credentials you set during installation.

## Test the xss attack

1. Access Admin Dashboard

Log in at: http://localhost:8080/index.php/login
Use the credentials you set during installation.

2. 
- Navigate to: Dashboard → System & Settings → SEO & Statistics
- locate "Header Extra Content"
- Add this comment <script>alert('XSS')</script>
- save changes
- Reload the page and approve the new version of the page for all visitors

3. Visit the site and any page portfolio as a normal user , you will get this:
![alt text](<Capture d’écran 2025-11-13 à 12.19.02.png>)


⚠️ Disclaimer
This setup is for educational and testing purposes only — demonstrating a stored XSS vulnerability in Concrete CMS 9.4.3. Do not test it on real servers usedin production
