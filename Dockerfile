FROM ruby:2.7.0

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get clean && apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    netcat-traditional \
    libpq-dev \
    nodejs

ENV RAILS_ROOT /var/www/ticket_selling_app
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY entrypoint_dev.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint_dev.sh
ENTRYPOINT ["sh", "entrypoint_dev.sh"]
