class User < ActiveRecord::Base
  include HTTParty
  attr_accessible :token, :username
  def self.token(code)#retrieve access token
    token = HTTParty.post("https://github.com/login/oauth/access_token?client_id=81e06b06df8444dfc400&client_secret=c29601141049ed316792c017d26fde2354ef530b&redirect_url=localhost:3000&code=#{code}")
    token = token.parsed_response
    token = token.split("=")
    token = token[1].split("&")
    token = token[0]
    if token1 = self.find_by_token(token)
      return token1.token
    else
      a = self.new(:token => token)
      a.save
      return token
    end
  end
  def self.user_details(token)#retrieve user details
    user_details = HTTParty.get("https://api.github.com/user?access_token=#{token}")
    user_details =  user_details.parsed_response
    username = user_details["login"]
    user =  self.find_by_token(token)
    user.update_attributes(:username => username)
    username
  end
  def self.check_username(username)#find username
    user = self.find_by_username(username)
  end
  def self.repository(username)#retrieve repositories
    repository = HTTParty.get("https://api.github.com/users/#{username}/repos")
    repo = Array.new
    repository.each_with_index do |i,j|
      repo.push({:name => i["name"], :id => i["id"]})
    end
    return repo
  end
  def self.branch(username, repository)#retrieve branches
    branches = HTTParty.get("https://api.github.com/repos/#{username}/#{repository}/branches")
    branch = Array.new
    branches.each_with_index do |i,j|
      branch.push({:name => i["name"]})
    end
    logger.info"-------------------------#{branch.inspect}"
    return branch
  end
  def self.commit(username, repository)#retrieve commits
    commits = HTTParty.get("https://api.github.com/repos/#{username}/#{repository}/commits")
    commit = Array.new
    commits.each_with_index do |i,j|
      commit.push({:name => i["commit"]["committer"]["name"],:message => i["commit"]["message"], :date => User.date(i["commit"]["committer"]["date"]) })
    end
    return commit
  end
  def self.date(date)#convert date
    date= date.to_date
    date.strftime("%d:%m:%y")
  end
  def self.organization(auth_token) #retrieve organizations
    organizations = HTTParty.get("https://api.github.com/user/orgs?access_token=#{auth_token}")
    organization = Array.new
    organizations.each_with_index do |i,j|
      organization.push({:name => i["login"]})
    end
    return organization
  end
  def self.org_repo(org,auth_token)#retrieve all repositories of organization
    repositories = HTTParty.get("https://api.github.com/orgs/#{org}/repos?access_token=#{auth_token}&type=private")
    repository = Array.new
    repositories.each_with_index do |i,j|
      repository.push({:owner => i["owner"]["login"], :name => i["name"],  :full_name => i["full_name"],:created_at => User.date(i["created_at"])})
    end
    return repository
  end
  def self.org_branch(auth_token, owner, repository)#retrieve all branches
    branches = HTTParty.get("https://api.github.com/repos/#{owner}/#{repository}/branches?access_token=#{auth_token}")
    branch = Array.new
    branches.each_with_index do |i,j|
      branch.push({:name => i["name"]})
    end
    return branch
  end
  def self.org_commit(auth_token,owner,repository,branch)#retrieve all commits of specific branch
    commits = HTTParty.get("https://api.github.com/repos/#{owner}/#{repository}/commits?access_token=#{auth_token}&sha=#{branch}")
    commit = Array.new
    commits.each_with_index do |i,j|
      commit.push({:name => i["commit"]["committer"]["name"],:message => i["commit"]["message"], :date => User.date(i["commit"]["committer"]["date"])})
    end
    return commit
  end
  def self.count_commits(commits)#count commits on date specific
    i=0
    date = Array.new
    count_commits = Array.new
    commits.each do |d|
      date[i]=d[:date]
      i = i+1;
    end
    date.sort!
    i=1
    temp=date[0]
    count = 1
    while i < date.length
      if temp==date[i]
        count =  count+1
      else
        count_commits.push({:date => temp, :time => count})
        temp=date[i]
        count = 1
      end
      i = i+1
    end
    return count_commits
  end
end
