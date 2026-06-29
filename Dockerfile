FROM nginx:alpine

# Copy files
COPY ["Tech Profile Builder v20.html", "/usr/share/nginx/html/index.html"]
COPY favicon.svg /usr/share/nginx/html/favicon.svg

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
