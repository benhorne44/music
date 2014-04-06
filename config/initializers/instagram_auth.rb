require 'instagram'

Instagram.client(
  client_id: ENV['INSTAGRAM_CLIENT_ID'],
  client_secret: ENV['INSTAGRAM_CLIENT_SECRET']
  )

