class Tweet < ActiveRecord::Base

  def self.new_client
    @client ||= Twitter::Client.new do |config|
      config.consumer_key        = "YOYO"
      config.consumer_secret     = ENV["TWITTER_SECRET_KEY"]
      config.oauth_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TWITTER_SECRET_TOKEN"]
    end
  end


end
