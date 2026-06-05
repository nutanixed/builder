# Tech Profile Builder Maintenance Guide

This document explains how to update the Tech Profile Builder, push changes to GitHub, and pull them into the production environment while preserving the favicon.

## 1. Development Workflow (On Local Host)

When a developer is working on a new version of the HTML file:

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/nutanixed/builder.git
    cd builder
    ```
2.  **Update the HTML**:
    Replace `tech_profile_builder_v8.5.html` with the new version.
3.  **Push to GitHub**:
    ```bash
    git add .
    git commit -m "Update HTML to new version"
    git push origin master
    ```
    *Note: GitHub Actions will automatically trigger a build, but our production setup pulls the source code.*

## 2. Production Update Workflow (On Server)

To pull the new code into production and rebuild the container:

1.  **Navigate to the builder directory**:
    ```bash
    cd /home/nutanix/plex-docker/builder
    ```
2.  **Pull the latest changes**:
    ```bash
    git pull
    ```
3.  **Rebuild and Restart**:
    Run this from the `plex-docker` root:
    ```bash
    cd /home/nutanix/plex-docker
    docker compose up -d --build builder
    ```

## 3. Preservation of Favicon

The system is configured to **always preserve the favicon** regardless of the HTML content.

### How it works:
In the `./builder/Dockerfile`, we explicitly copy the local `favicon.svg` into the Nginx image and overwrite the HTML to be the `index.html`:

```dockerfile
FROM nginx:alpine
# This line takes WHATEVER html file exists and makes it the index
COPY tech_profile_builder_v8.5.html /usr/share/nginx/html/index.html
# This line ensures our specific favicon is ALWAYS used
COPY favicon.svg /usr/share/nginx/html/favicon.svg
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Important Note:
If the filename of the HTML changes (e.g., to `v9.0.html`), you **must** update the `Dockerfile` to point to the new filename before running the production update.
