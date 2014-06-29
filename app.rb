# -*- coding: utf-8 -*-
require "sinatra"

require "pocket"

enable :sessions

# CALLBACK_URL = "http://localhost:4567/oauth/callback"
CALLBACK_URL = "http://iriguti.herokuapp.com/oauto/callback"

Pocket.configure do |config|
  config.consumer_key = '29328-0046aa03e13e9ff2fccd92c8'
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

  items = info["list"].to_a.sort_by{ rand }.take(3).map do |v|
    item  = v[1]
    url   = item["resolved_url"]
    title = item["resolved_title"]

    <<EOF
<tr>
  <td><a href=\"#{url}\" target=\"_blank\">#{title}</a></td>
  <td><a href=\"/archive/#{item["item_id"]}\" target=\"_blank\">[DONE]</a></td>
</tr>
EOF
  end.join("\n")

  <<EOF
<h1>Iriguti</h1>
<table>
#{items}
</table>
EOF
end

get "/archive/:item_id" do
  client = Pocket.client(:access_token => session[:access_token])
  info = client.modify([{action: "archive", item_id: params[:item_id]}])
  "Finish reading the #{params[:item_id]}"
end
