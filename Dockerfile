FROM ruby:2.7.3
RUN gem install rails -v 6.1.3
RUN gem install bundler:2.2.15
RUN apt update -y && \ 
apt install -y git-core curl zlib1g-dev build-essential \
libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common \
libffi-dev libgdbm-dev libncurses5-dev automake libtool bison libffi-dev && \
apt-get install libpq-dev -y && \
apt install -y nodejs npm && \
npm install -g yarn
WORKDIR /var/www/
RUN git clone https://github.com/naveen2112/dockerror.git
WORKDIR /var/www/dockerror
RUN bundle install
ENV RAILS_ENV=production \
DATABASE_NAME=postgres \
DATABASE_USERNAME=postgres \
DATABASE_PASSWORD=admin123 \
DATABASE_HOSTNAME=rorbill.cfetpjdspyv9.ap-south-1.rds.amazonaws.com \
DATABASE_PORT=5432
RUN export SECRET_KEY_BASE=$(bundle exec rake secret) && echo "export SECRET_KEY_BASE=$SECRET_KEY_BASE" >> ~/.bashrc
CMD ["bash", "-c", "RAILS_ENV=production bundle exec rails s"]
