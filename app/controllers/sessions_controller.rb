class SessionsController < ApplicationController
  def create  
    raise request.env["omniauth.auth"].to_yaml
  end

  def destroy
    session[:user_id] = session[:token] = nil
    redirect_to root_path
  end
end
