FROM ruby:2.2.4

RUN mkdir -p /app
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && \
    bundle install --jobs 20 --retry 5

# Copy the application
COPY . ./

CMD ["bin/run"]
