#using this awesome prebuild image:
FROM '123majumundur/php-7.1-nginx:cicd'
MAINTAINER KusHaShi <kusvihawan@gmail.com>

#Install prestissimo for faster deps instalation
RUN composer global require hirak/prestissimo

#Make dir for hosting the apps
RUN mkdir /home/app/app
WORKDIR /home/app/app

#install dependencies
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer

#code codebase
COPY --chown=app:root . ./

#finish composer
#RUN composer dump-autoload
RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080