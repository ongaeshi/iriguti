class HomeController < ApplicationController
  def index
    if session[:token]
      client = Pocket.client(:access_token => session[:token])
      # info = client.retrieve(:detailType => :complete, :count => 3)
      info = client.retrieve(:detailType => :simple)
      @items = info["list"].to_a.sort_by{ rand }.take(3).map{|v| v[1]}
    else
      @items = []
    end
  end

  def archive
    client = Pocket.client(:access_token => session[:token])
    info = client.modify([{action: "archive", item_id: params[:item_id]}])
  end

  def add
    client = Pocket.client(:access_token => session[:token])
    info = client.add({url: params[:url]})
  end
end
