# Set nginx base image
FROM nginx:latest

# RUN apt-get update && apt-get install -y \
#     netcat-traditional curl \
#     procps net-tools \
#     && rm -rf /var/lib/apt/lists/* \

RUN rm /etc/nginx/conf.d/*.conf

# Copy custom configuration file from the current directory
COPY ./sites/*.conf /etc/nginx/conf.d/
