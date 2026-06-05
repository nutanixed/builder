FROM nginx:alpine
COPY tech_profile_builder_v8.5.html /usr/share/nginx/html/index.html
COPY favicon.svg /usr/share/nginx/html/favicon.svg
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
