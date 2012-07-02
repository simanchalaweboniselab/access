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
    respond_with do |format|
      if user=User.check_username(params[:username])
        format.json {render :json => {:success => true, :auth_token => user.token, :username => user.username }}
      else
        format.json {render :json => {:success => false}}
      end
    end
  end
  #DONE retrieve repository name and id
  def repository
    repository = User.repository(params[:auth_token],params[:username])
    respond_with do |format|
      if !repository.empty?
        format.json {render :json => {:success => true, :repository => repository }}
      else
        format.json {render :json => {:message => "repository not found" }}
      end
    end
  end
  #DONE retrieve branches name
  def branch
    branch = User.branch(params[:auth_token],params[:username],params[:repository])
    respond_with do |format|
      if !branch.empty?
        format.json {render :json => {:success => true, :branches => branch }}
      else
        format.json {render :json => {:success => false }}
      end
    end
  end
  #DONE retrieve commits
  def commit
    commits = User.commit(params[:auth_token],params[:username],params[:repository],params[:branch])
    count_commits = User.count_commits(commits)
    respond_with do |format|
      if !commits.empty?
        format.json {render :json => {:success => true, :commits => commits, :count_commits => count_commits }}
      else
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
  #DONE retrieve all repository of specific organization organization
  def org_repository
    repositories = User.org_repo(params[:organization],params[:auth_token])
    respond_with do |format|
      if !repositories.empty?
        format.json {render :json => {:success => true, :repository => repositories }}
      else
        format.json {render :json => {:message => "not found" }}
      end
    end
  end
  #DONE retrieve all branches under specific repository of organization
  def org_branch
    branches = User.org_branch(params[:auth_token],params[:owner],params[:repository])
    respond_with do |format|
      if !branches.empty?
        format.json {render :json => {:success => true, :branches => branches }}
      else
        format.json {render :json => {:message => "not found" }}
      end
    end
  end
  #DONE retrieve all commits
  def org_commit
    commits = User.org_commit(params[:auth_token],params[:owner],params[:repository],params[:branch])
    count_commits = User.count_commits(commits)
    committer = User.committer(commits)
    respond_with do |format|
      if !commits.empty?
        format.json {render :json => {:success => true, :committer => committer, :commits => commits, :count_commits => count_commits }}
      else
        format.json {render :json => {:message => "not found" }}
      end
    end
  end
  #DONE retrieve all commits based on name and date
  def committer_commit
    commits = User.org_commit(params[:auth_token],params[:owner],params[:repository],params[:branch])
    committer_commits = User.committer_commits(commits,params[:committer_name],params[:date])
    respond_with do |format|
      if !committer_commits.empty?
        format.json{render :json => {:success => true, :committer_commits => committer_commits}}
      else
        format.json {render :json => {:message => "not found" }}
      end
    end
  end
  #DONE retrieve all members of organization
  def org_member
    members = User.org_member(params[:auth_token], params[:organization])
    respond_with do |format|
      if !members.empty?
        format.json{render :json => {:success => true, :members => members}}
      else
        format.json {render :json => {:message => "not found" }}
      end
    end
  end
end