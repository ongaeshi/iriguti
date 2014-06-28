# -*- coding: utf-8 -*-
require "sinatra"

require "pocket"

enable :sessions

CALLBACK_URL = "http://localhost:4567/oauth/callback"

Pocket.configure do |config|
  config.consumer_key = '10188-3565cd04d1464e6d0e64b67f'
end

get '/reset' do
  puts "GET /reset"
  session.clear
end

get "/" do
  puts "GET /"
  puts "session: #{session}"

  if session[:access_token]
    '
<a href="/add?url=http://getpocket.com">Add Pocket Homepage</a>
<a href="/retrieve">Retrieve single item</a>
    '
  else
    '<a href="/oauth/connect">Connect with Pocket</a>'
  end
end

get "/oauth/connect" do
  puts "OAUTH CONNECT"
  session[:code] = Pocket.get_code(:redirect_uri => CALLBACK_URL)
  new_url = Pocket.authorize_url(:code => session[:code], :redirect_uri => CALLBACK_URL)
  puts "new_url: #{new_url}"
  puts "session: #{session}"
  redirect new_url
end

get "/oauth/callback" do
  puts "OAUTH CALLBACK"
  puts "request.url: #{request.url}"
  puts "request.body: #{request.body.read}"
  result = Pocket.get_result(session[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = result['access_token']
  puts result['access_token']
  puts result['username']	
  # Alternative method to get the access token directly
  #session[:access_token] = Pocket.get_access_token(session[:code])
  puts session[:access_token]
  puts "session: #{session}"
  redirect "/"
end

get '/add' do
  client = Pocket.client(:access_token => session[:access_token])
  info = client.add :url => 'http://getpocket.com'
  "<pre>#{info}</pre>"
end

get "/retrieve" do
  client = Pocket.client(:access_token => session[:access_token])
  # info = client.retrieve(:detailType => :complete, :count => 3)
  info = client.retrieve(:detailType => :simple)

  html = "<h1>Iriguti</h1>"
  html += "<ul>\n"

  info["list"].to_a.sort_by{ rand }.take(3).each do |v|
    html += "<li><a href=\"#{v[1]["resolved_url"]}\" target=\"_blank\">#{v[1]["resolved_title"]}</a></li>\n"
  end
  
  html += "</ul>"

  html
end