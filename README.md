# Twitter Bot for Pajat.se

This bot will scan every mention of the twitter user @pajatapp and
forward the tweet to pajat.

Each forwarded Tweet will be favorited by @pajatapp. It can be seen as
an confirmation that the tweet has been forwarded and @pajatapp will
know next time that the favorited tweet is already forwarded.

Each Tweet must pass these rules to be forwarded:

1. @pajatapp must be mentioned
2. it must have a location attached to it
3. it can not be favorited by @pajatapp

## Setup the bot

To setup this bot you must have an `.env` file in the project root
directory. It should include API settings for @pajatapp or the other
user you want to use this bot with.

Create the file with `touch .env` and copy paste the content below to
this file. Then you need to fill in each variable with your values

    CONSUMER_KEY="your-consumer-key"
    CONSUMER_SECRET="your-cunsumer-secret"
    ACCESS_TOKEN="your-access-token"
    ACCESS_TOKEN_SECRET="your-access-token-secret"


### Install the application using docker-compose

First you need a working docker environment with docker-compose. I
will not cover the setup for that here.

    docker-compose build

### Install the application without docker-compose

Install the ruby version matching the version number you can find in
`.ruby-version` file.

Then you install rest of the dependencies

    gem install bundler
    bundle install

### Run the application using docker-compose

    docker-compose up

### Run the application without usgin docker-compose

    bin/run
