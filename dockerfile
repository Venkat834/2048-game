FROM ubuntu:22.04

# Install nginx, curl, unzip
RUN apt-get update && apt-get install -y nginx zip curl unzip

# Download and extract the 2048 game
RUN curl -L -o /var/www/html/master.zip https://codeload.github.com/Venkat834/2048-game/zip/master && \
    cd /var/www/html && \
    unzip master.zip && \
    mv 2048-game-master/* . && \
    rm -rf 2048-game-master master.zip

# Expose port 80 and run nginx
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
