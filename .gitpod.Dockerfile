FROM gitpod/workspace-full:latest

USER root

RUN apt-get update

## Ruby
RUN curl -L https://get.rvm.io | bash -s stable
#Set env just in case
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.6.5"
RUN /bin/bash -l -c "gem install bundler"
WORKDIR ~/myapp
COPY Gemfile ~/myapp/Gemfile
COPY Gemfile.lock ~/myapp/Gemfile.lock
RUN /bin/bash -l -c "rvm use --default 2.6.5"
RUN sudo usermod -a -G rvm gitpod
RUN sudo chmod 664 /home/gitpod/.rvm/gems/ruby-2.6.5/*

USER gitpod
WORKDIR ~/myapp

RUN /bin/bash -l -c "bundle install"
