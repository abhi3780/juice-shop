# OWASP Juice Shop - An intentionally insecure Javascript Web Application
FROM node:6-alpine
MAINTAINER      Bjoern Kimminich <bjoern.kimminich@owasp.org>
LABEL version = "4.2.2"

## CREATE juice-shop-app USER ##

# Create the home directory for the new app user.
RUN mkdir -p /home/juice-shop-app

# Create an juice-shop-app user so our program doesn't run as root.
RUN addgroup -S juice-shop-group && \
    adduser -S -D juice-shop-app -G juice-shop-group -h /home/juice-shop-app

# Set the home directory to our juice-shop-app user's home.
ENV HOME=/home/juice-shop-app
ENV APP_HOME=/home/juice-shop-app/juice-shop-workdir

## SETTING UP THE APP ##
RUN mkdir $APP_HOME

RUN apk update && apk add git

COPY .  $APP_HOME
WORKDIR $APP_HOME

# Chown all the files to the app user.
RUN chown -R juice-shop-app:juice-shop-group $APP_HOME

# Change to the app user.
USER juice-shop-app

RUN npm install --production --unsafe-perm

EXPOSE  3000

ENTRYPOINT exec npm start
