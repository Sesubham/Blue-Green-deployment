# Blue-Green-deployment

Project
A simple demonstration of blue-green deployment strategy using Docker and shell scripts.
What is Blue-Green Deployment?
Blue-green deployment is a strategy that reduces downtime by running two identical production environments (Blue and Green). Only one environment serves live traffic at a time. When deploying a new version:

Deploy to the inactive environment
1. Deploy to the inactive environment
2. Test the new version
3. Switch traffic to the new environment
4. Keep the old environment as a quick rollback option

Project Structure

blue-green-deployment/
├── app/
│   ├── blue/
│   │   └── index.html
│   ├── green/
│   │   └── index.html
│   └── Dockerfile
├── scripts/
│   ├── deploy.sh
│   ├── switch.sh
│   └── rollback.sh
├── nginx/
│   └── nginx.conf
├── docker-compose.yml
└── README.md

Prerequisites

1. Docker installed
2. Docker Compose installed
3. Basic terminal/command line knowledge

Architecture

                    ┌─────────────┐
                    │   NGINX     │
                    │  (Port 80)  │
                    └──────┬──────┘
                           │
              ┌────────────┴───────────┐
              │                        │
         ┌────▼────┐              ┌────▼────┐
         │  Blue   |              │  Green  │
         │ (8081)  │              │ (8082)  │
         │ v1.0    │              │ v2.0    │
         └─────────┘              └─────────┘


Key DevOps Concepts Demonstrated

✅ Containerization - Using Docker for consistent environments
✅ Zero-Downtime Deployment - No service interruption during updates
✅ Quick Rollback - Instant revert to previous version
✅ Infrastructure as Code - All configuration in version control
✅ Automation - Scripted deployment process
✅ Load Balancing - NGINX routing between environments

License

MIT License - Feel free to use for your portfolio!
