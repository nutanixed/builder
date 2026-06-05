# Tech Profile Builder

A modernized tool for building Nutanix Technical Profiles. This repository contains the static assets and Docker configuration for the Tech Profile Builder application.

## 🚀 Features

- **Modern UI**: Reconstructed for a cleaner, more responsive experience.
- **Nginx Powered**: Lightweight production-ready serving via Docker.
- **CI/CD Integrated**: Automated Docker builds via GitHub Actions.
- **Persistent Branding**: Favicon and core assets are preserved through builds.

## 🛠️ Quick Start

### Deployment
To run this container as part of the `plex-docker` stack:

```bash
docker compose up -d --build builder
```

### Development
1. Clone the repository locally.
2. Edit `tech_profile_builder_v8.5.html`.
3. Push changes to `master` to trigger CI/CD or pull manually on the production server.

## 📖 Maintenance

Detailed instructions for pushing new code, production updates, and maintaining the IT stack can be found in [MAINTENANCE.md](./MAINTENANCE.md).

---
*Built for Nutanix Technical Profile specifications.*
