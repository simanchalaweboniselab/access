class HomeController < ApplicationController
  respond_to :json
  def index
  end
  #DONE retrieve access token using code
  def access_token
    token = Home.token(params[:code])
    username = Home.user_details(token)
    respond_with do |format|
      format.json {render :json => {:success => true, :auth_token => token, :username => username, :repository => repository }}
    end
  end
  #DONE retrieve access token using username
  def auth_token
    if user=Home.check_username(params[:username])
      respond_with do |format|
        format.json {render :json => {:success => true, :auth_token => user.token, :username => user.username, :repository => repository }}
      end
    else
      respond_with do |format|
        format.json {render :json => {:success => false}}
      end
    end
  end
  #DONE retrieve repository name and id
  def repository
    username = params[:username]
    repository = Home.repository(username)
    respond_with do |format|
      format.json {render :json => {:success => true, :repository => repository }}
    end
  end
  def branch
    branch = Home.branch(params[:username],params[:repository])
    respond_with do |format|
      format.json {render :json => {:success => true, :branch => branch }}
    end
  end
end


