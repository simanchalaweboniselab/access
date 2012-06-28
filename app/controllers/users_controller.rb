class UsersController < ApplicationController
  #DONE retrieve access token using username
  def access_token
    token = User.token(params[:code])
    username = Home.user_details(token)
    respond_with do |format|
      format.json {render :json => {:success => true, :auth_token => token, :username => username }}
    end
  end
  #DONE retrieve access token using username
  def auth_token
    if user=User.check_username(params[:username])
      respond_with do |format|
        format.json {render :json => {:success => true, :auth_token => user.token, :username => user }}
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
    if repository = User.repository(username)
      respond_with do |format|
        format.json {render :json => {:success => true, :repository => repository }}
      end
    else
      respond_with do |format|
        format.json {render :json => {:message => "repository not found" }}
      end
    end
  end
  #DONE retrieve branches name
  def branch
    branch = User.branch(params[:username],params[:repository])
    if !branch.empty?
      respond_with do |format|
        format.json {render :json => {:success => true, :branch => branch }}
      end
    else
      respond_with do |format|
        format.json {render :json => {:success => false }}
      end
    end
  end

end