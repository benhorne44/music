class LandingController < ApplicationController

  def index
    response = Twitter.user_timeline("zheckendorf", count: 3)
    event_response_raw = Faraday.get("http://api.bandsintown.com/artists/Zach%20Heckendorf/events.json?api_version=2.0&app_id=zach_heckendorf")
    event_response = JSON.parse(event_response_raw.body)

    # raise event_response.inspect
    @tweet = response.first
    @tweets = response
    # raise @tweet.inspect
  end
end
