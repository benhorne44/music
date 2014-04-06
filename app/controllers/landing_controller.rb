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
    # @events = events
    # @events = event_response["resultsPage"]["results"]["event"].first
    # raise blog_posts["response"]["posts"].map(&:keys).uniq.inspect
  end
end
