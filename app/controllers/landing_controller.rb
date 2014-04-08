class LandingController < ApplicationController

  def index
    response = Twitter.user_timeline("zheckendorf", count: 5)
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
    # 98594d38345f45c3863b96934a4e6ed7
    # response = Faraday.get("https://api.instagram.com/oauth/authorize/?client_id=c9d81054cf0141f0a3a00d4a36473da0&redirect_uri=http://localhost:3000/instagram&response_type=access_token")
    response = Faraday.get("https://api.instagram.com/v1/users/226631511/?access_token=258991520.c9d8105.9cee1d23e4a64b48a1d6bf3d16bb1cb1")

    @instagram = JSON.parse(response.body)

    # @events = events
    # @events = event_response["resultsPage"]["results"]["event"].first
    raise @instagram.inspect
  end

  def instagram
    fail
  end
end
