# Dockerfile for the generating searchumd Rails application Docker image
#
# To build:
#
# docker build -t docker.lib.umd.edu/student-applications:<VERSION> -f Dockerfile .
#
# where <VERSION> is the Docker image version to create.

FROM ruby:2.7.2-slim

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
#
# "file" and "imagemagick" are needed by the "paperclip" gem
RUN apt-get update && \
    apt-get install -y build-essential \
                       git \
                       libpq-dev \
                       libsqlite3-dev \
                       nodejs \
                       file \
                       imagemagick && \
    apt-get clean

# Create a user for the web app.
RUN addgroup --gid 9999 app && \
    adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app && \
    usermod -L app

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.

USER app
WORKDIR /home/app

ENV RAILS_ENV=production

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY --chown=app:app Gemfile Gemfile.lock /home/app/webapp/
RUN cd /home/app/webapp && \
    gem install bundler --version 1.17.3 && \
    bundle install --jobs 20 --retry 5 --without development test && \
    cd ..

# Copy the main application.
COPY  --chown=app:app . /home/app/webapp/

# Copy Rails application start script
COPY --chown=app:app docker_config/student-applications/rails_start.sh /home/app/webapp

# RAILS_RELATIVE_URL_ROOT and SCRIPT_NAME are only needed if application is
# running on a URL subpath
# ENV RAILS_RELATIVE_URL_ROOT=/subpath
# ENV SCRIPT_NAME=/subpath

# The following SECRET_KEY_BASE variable is used so that the
# "assets:precompile" command will run run without throwing an error.
# It will have no effect on the application when it is actually run.
#
# Similarly, the PROD_DATABASE_ADAPTER variable is needed for the
# "assets:precompile" Rake task to complete, but will have no effect
# on the application when it is actually run.
ENV SECRET_KEY_BASE=IGNORE_ME
RUN cd /home/app/webapp && \
    PROD_DATABASE_ADAPTER=postgresql bundle exec rails assets:precompile && \
    cd ..

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts.
CMD ["/home/app/webapp/rails_start.sh"]
