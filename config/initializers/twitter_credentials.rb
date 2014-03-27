Twitter.configure do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_SECRET_KEY"]
  config.oauth_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.oauth_token_secret = ENV["TWITTER_SECRET_TOKEN"]
end
