FROM ruby:3.1.2


#Install 3rd Party dependencies
RUN apt update && apt -y install nodejs libvips42

# working directory
RUN mkdir /app
WORKDIR /app

# Script run at initialization
COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT [ "/app/docker-entrypoint.sh" ]