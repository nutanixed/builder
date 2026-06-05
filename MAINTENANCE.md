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

You can update the production site manually or use the automated script.

### Option A: Automated Script (Recommended)
Run the following script to check for updates and rebuild only if changes exist:
```bash
/home/nutanix/plex-docker/builder/update_production.sh
```

### Option B: Manual Update
To pull the new code into production and rebuild the container manually:

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

## 3. Favicon Maintenance

The system is configured to **preserve** the favicon regardless of the HTML content, but you can also **update** it easily.

### How to Update the Favicon:
1.  Replace the `favicon.svg` file in the root of the `builder` directory with your new SVG icon.
2.  Commit and push the change:
    ```bash
    git add favicon.svg
    git commit -m "Update favicon"
    git push origin master
    ```
3.  Pull and rebuild on the production server (see Section 2).

### How it works (Technical Detail):
In the `./builder/Dockerfile`, we explicitly copy the local `favicon.svg` into the Nginx image. 

Additionally, we use a `sed` command during the build to automatically inject the correct `<link>` tags into the `<head>` of the HTML file:
```dockerfile
RUN sed -i '/<head>/a \  <link rel="icon" type="image/svg+xml" href="favicon.svg" sizes="any">\n  <link rel="shortcut icon" type="image/svg+xml" href="favicon.svg">' /usr/share/nginx/html/index.html
```
This ensures that even if the developer's HTML file is missing the favicon code, the production site will always have it.

### Important Note:
If the filename of the HTML changes (e.g., to `v9.0.html`), you **must** update the `Dockerfile` to point to the new filename before running the production update.
