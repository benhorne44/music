class LandingController < ApplicationController

  def index
    response = Twitter.user_timeline("zheckendorf", count: 5)
    @tweet = response.first
    @tweets = response

    response = Faraday.get("http://api.songkick.com/api/3.0/artists/2849436/calendar.json?apikey=#{ENV['SONGKICK_API_KEY']}")
    event_response = JSON.parse(response.body)
    events = event_response["resultsPage"]["results"]["event"] || []
    if events == []
      response = Faraday.get("http://api.songkick.com/api/3.0/artists/2849436/gigography.json?apikey=#{ENV['SONGKICK_API_KEY']}")
      event_response = JSON.parse(response.body)
      events = event_response["resultsPage"]["results"]["event"] || []
    end

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
    @events = @events[-8...-1]

    response = Faraday.get("http://api.tumblr.com/v2/blog/zachheckendorf.tumblr.com/posts/text?api_key=#{ENV['TUMBLR_OAUTH_KEY']}")
    blog_posts = JSON.parse(response.body)
    @blog_posts = []
    # @blog_posts = blog_posts["response"]["posts"].first
    blog_posts["response"]["posts"].each do |post|
      if post["body"].nil?
        body = post["description"]
      elsif post["description"].nil?
        body = post["body"]
      else
        body = ''
      end
      @blog_posts << {
        "url" => post["url"],
        "date" => post["date"],
        "title" => post["title"],
        # "body" => body || ''
        "body" => post["body"]
        # "description" => post["description"]
      }
    end
    @blog_posts = @blog_posts[0...3]
    # response = Faraday.get("https://api.instagram.com/oauth/authorize/?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}&redirect_uri=http://localhost:3000/instagram&response_type=access_token")
    response = Faraday.get("https://api.instagram.com/v1/users/226631511/media/recent/?access_token=#{ENV['INSTAGRAM_ACCESS_TOKEN']}")

    instagram = JSON.parse(response.body)
    @instagram = []
    instagram["data"][0...12].each do |image|
      @instagram << {"link" => image["link"], "thumbnail" => image["images"]["thumbnail"]["url"]}
    end
    # @events = events
    # @events = event_response["resultsPage"]["results"]["event"].first
    # raise @instagram.first.inspect
  end

  def instagram
    fail
  end
end
