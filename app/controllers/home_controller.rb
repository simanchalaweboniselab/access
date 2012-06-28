class HomeController < ApplicationController
  #respond_to :json
  def index
  end
  ##DONE retrieve access token using code
  #def access_token
  #  token = Home.token(params[:code])
  #  username = Home.user_details(token)
  #  respond_with do |format|
  #    format.json {render :json => {:success => true, :auth_token => token, :username => username }}
  #  end
  #end
  ##DONE api for auth_token
  #def auth_token
  #  if user=Home.check_username(params[:username])
  #    respond_with do |format|
  #      format.json {render :json => {:success => true, :auth_token => user.token, :username => user.username }}
  #    end
  #  else
  #    respond_with do |format|
  #      format.json {render :json => {:success => false}}
  #    end
  #  end
  #end
  ##DONE api for repository
  #def repository
  #  username = params[:username]
  #  repository = Home.repository(username)
  #  respond_with do |format|
  #    format.json {render :json => {:success => true, :repository => repository }}
  #  end
  #end
  ##DONE api for branches
  #def branch
  #  branch = Home.branch(params[:username],params[:repository])
  #  if !branch.empty?
  #    respond_with do |format|
  #      format.json {render :json => {:success => true, :branch => branch }}
  #    end
  #  else
  #    respond_with do |format|
  #      format.json {render :json => {:success => false }}
  #    end
  #  end
  #end
  #def commit
  #  commits = Home.commit(params[:username],params[:repository])
  #  if !commits.empty?
  #    respond_with do |format|
  #      format.json {render :json => {:success => true, :commits => commits }}
  #    end
  #  else
  #    respond_with do |format|
  #      format.json {render :json => {:success => false }}
  #    end
  #  end
  #end
end