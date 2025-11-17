FROM klakegg/hugo:0.147.1-ext-alpine AS builder
WORKDIR /src

COPY . .

# Build your site (minify enabled)
RUN hugo --minify

FROM nginx:stable-alpine

# Clean out default NGINX html
RUN rm -rf /usr/share/nginx/html/*

# Copy built site from Hugo builder
COPY --from=builder /src/public /usr/share/nginx/html

# DigitalOcean App Platform expects apps to listen on 8080
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

