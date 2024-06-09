# Use the official Nginx image as the base image
FROM nginx:mainline-alpine

# Set environment variables
ENV CACHE_SIZE 64g
ENV CACHE_TTL 1y
ENV CACHE_INACTIVE_PRUNE_INTERVAL 90d
ENV CACHE_UPSTREAM_ENDPOINT asset-cdn.glb.agni.lindenlab.com
ENV CACHE_LOCAL_ENDPOINT localnode.local

# Copy custom configuration files into the image
COPY ./nginx/webroot /data/nginx/webroot
COPY ./healthcheck.sh /data/healthcheck.sh
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/localnode.conf /etc/nginx/conf.d/localnode.conf

# Define cache and logs directories as volumes
VOLUME /data/nginx/cache
VOLUME /data/nginx/logs

# Set up healthcheck
HEALTHCHECK --interval=1m --timeout=5s --start-period=5s --retries=2 CMD ["sh", "/data/healthcheck.sh"]

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
