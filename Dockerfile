FROM ruby:2.7.3
RUN gem install rails -v 6.1.3
RUN apt update -y && \ 
apt install -y git-core curl zlib1g-dev build-essential \
libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common \
libffi-dev libgdbm-dev libncurses5-dev automake libtool bison libffi-dev && \
apt-get install libpq-dev -y && \
apt install -y nodejs npm && \
npm install -g yarn
WORKDIR /var/www/
RUN git clone https://github.com/naveen2112/devopsrorbilling.git
WORKDIR /var/www/devopsrorbilling
RUN bundle install
RUN export RAILS_ENV=production
RUN export SECRET_KEY_BASE=$(bundle exec rake secret) && echo "export SECRET_KEY_BASE=$SECRET_KEY_BASE" >> ~/.bashrc
RUN RAILS_ENV=production rake db:create
RUN RAILS_ENV=production rake db:migrate
RUN RAILS_ENV=production rake assets:precompile
EXPOSE 3000
CMD ["bash", "-c", "RAILS_ENV=production bundle exec rails s"]
