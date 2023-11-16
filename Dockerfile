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
RUN export SECRET_KEY_BASE=$(bundle exec rake secret) && echo "export SECRET_KEY_BASE=$SECRET_KEY_BASE" >> ~/.bashrc
COPY ./script.sh .
RUN chmod +x ./script.sh
ENTRYPOINT ["./script.sh"]
CMD ["bundle", "exec", "rails", "s"]
