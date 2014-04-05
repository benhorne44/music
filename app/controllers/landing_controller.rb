class LandingController < ApplicationController

  def index
    response = Twitter.user_timeline("zheckendorf", count: 3)
    @tweet = response.first
    @tweets = response

    response = Faraday.get("http://api.songkick.com/api/3.0/artists/2849436/calendar.json?apikey=#{ENV['SONGKICK_API_KEY']}")
    event_response = JSON.parse(response.body)
    events = event_response["resultsPage"]["results"]["event"]
    @events = []
    events.each do |event|
      @events << {
        "venue" => event["venue"],
        "headliner" => event["performance"].first,
        "supporting" => event["performance"][1],
        # look into multiple supporting acts
        "time" => event["start"]["datetime"],
        "location" => event["location"],
        "link" => event["uri"]
      }
    end
    @events = @events[0...6]
    # @events = events
    # @events = event_response["resultsPage"]["results"]["event"].first
    # raise events.inspect
  end
end
