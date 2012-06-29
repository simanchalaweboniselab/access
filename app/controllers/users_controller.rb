class UsersController < ApplicationController
  #DONE retrieve access token using username
  respond_to :json
  def access_token
    token = User.token(params[:code])
    username = User.user_details(token)
    respond_with do |format|
      format.json {render :json => {:success => true, :auth_token => token, :username => username }}
    end
  end
  #DONE retrieve access token using username
  def auth_token
    if user=User.check_username(params[:username])
      respond_with do |format|
        format.json {render :json => {:success => true, :auth_token => user.token, :username => user.username }}
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
    repository = User.repository(username)
    if !repository.empty?
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
  #DONE retrieve commits
  def commit
    commits = User.commit(params[:username],params[:repository])
    if !commits.empty?
      respond_with do |format|
        format.json {render :json => {:success => true, :commits => commits }}
      end
    else
      respond_with do |format|
        format.json {render :json => {:message => "not found"}}
      end
    end
  end
  #DONE retrieve organization_list
  def organization
    organizations = User.organization(params[:auth_token])
    respond_with do |format|
      if !organizations.empty?
        format.json {render :json => {:success => true, :organizations => organizations }}
      else
        format.json {render :json => {:message => "not found" }}
      end
    end
  end
  #TODO retrieve all repository of specific organization organization
  def organization_repository
    repositories = User.org_repo(params[:organization],params[:auth_token])
    respond_with do |format|
      if !repositories.empty?
        format.json {render :json => {:success => true, :repository => repositories }}
      else
        format.json {render :json => {:message => "not found" }}
      end
    end
  end
end