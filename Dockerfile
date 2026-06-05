FROM nginx:alpine

# Copy files
COPY tech_profile_builder_v8.5.html /usr/share/nginx/html/index.html
COPY favicon.svg /usr/share/nginx/html/favicon.svg

# Inject the favicon link tags into the <head> of the HTML
RUN sed -i '/<head>/a \  <link rel="icon" type="image/svg+xml" href="favicon.svg" sizes="any">\n  <link rel="shortcut icon" type="image/svg+xml" href="favicon.svg">' /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
