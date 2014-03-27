class LandingController < ApplicationController

  def index
    response = Twitter.user_timeline("zheckendorf", count: 3)
    # raise response.inspect
    @tweet = response.first
    @tweets = response
    # raise @tweet.inspect
  end
end
