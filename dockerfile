# Build site using Node JS
FROM node:23-slim

# Install wget, nginx, and serve
RUN apt-get update && apt-get install -y wget nginx && npm install -g serve

ARG BUILD_DATE

LABEL \
  maintainer="Jordan Roher <jordan@notclickable.com>" \
  org.opencontainers.image.authors="Jordan Roher <jordan@notclickable.com>" \
  org.opencontainers.image.title="starbase-80" \
  org.opencontainers.image.description="A nice app grid of icons for Docker services" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.stop-timeout=1

WORKDIR /app

COPY package.json .
RUN npm i

COPY . .

COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

ENV NODE_ENV=production
ENV TITLE="My Website"
ENV LOGO="/logo.png"
ENV HEADER="true"
ENV HEADERLINE="true"
ENV HEADERTOP="false"
ENV CATEGORIES="normal"
ENV BGCOLOR="theme(colors.slate.50)"
ENV BGCOLORDARK="theme(colors.gray.950)"
ENV CATEGORYBUBBLECOLORLIGHT="theme(colors.white)"
ENV CATEGORYBUBBLECOLORDARK="theme(colors.black)"
ENV THEME="auto"
ENV NEWWINDOW="true"
ENV HOVER="none"

# "node" serves static files via Node (no nginx), "nginx" uses nginx
ENV SERVER_MODE="nginx"

COPY version /

STOPSIGNAL SIGTERM
RUN chmod +x /app/docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh"]