# -*- coding: utf-8 -*-
require "sinatra"
require "pocket"

enable :sessions

p ENV['RACK_ENV'] 

# CALLBACK_URL = "http://localhost:4567/oauth/callback"
CALLBACK_URL = "http://iriguti.herokuapp.com/oauth/callback"

Pocket.configure do |config|
  config.consumer_key = '29328-0046aa03e13e9ff2fccd92c8'
end

get '/reset' do
  session.clear
end

get "/" do
  unless session[:access_token]
    return '<a href="/oauth/connect">Connect with Pocket</a>'
  end

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

get "/oauth/connect" do
  session[:code] = Pocket.get_code(:redirect_uri => CALLBACK_URL)
  new_url = Pocket.authorize_url(:code => session[:code], :redirect_uri => CALLBACK_URL)
  redirect new_url
end

get "/oauth/callback" do
  result = Pocket.get_result(session[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = result['access_token']
  redirect "/"
end

get "/archive/:item_id" do
  client = Pocket.client(:access_token => session[:access_token])
  info = client.modify([{action: "archive", item_id: params[:item_id]}])
  "Finish reading the #{params[:item_id]}"
end
