$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "rubygems"
require "bundler/setup"
require "twitter"
require "tweet"

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

def report(tweet)
  tweet.send_to_pajat!
  @client.favorite tweet.__getobj__
rescue Twitter::Error::BadRequest
  puts "Got BadRequest when trying to favorite tweet #{tweet.uri}"
rescue => e
  puts "Tryed to report #{tweet.uri}. Got this response from pajat:"
  puts e.response
end

def should_be_reported?(object)
  (object.is_a?(Twitter::Tweet) && object.place?) && !object.favorited?
end

def parse_timeline
  @client.mentions_timeline.each do |object|
    next unless should_be_reported? object
    tweet = Tweet.new(object)
    report(tweet)
  end
end

loop do
  parse_timeline
  five_minutes = (60 * 5)
  sleep five_minutes
end
