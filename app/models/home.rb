class Home < ActiveRecord::Base
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
  def self.user_details(token)#
    user_details = HTTParty.get("https://api.github.com/user?access_token=#{token}")
    user_details =  user_details.parsed_response
    username = user_details["login"]
    user =  self.find_by_token(token)
    user.update_attributes(:username => username)
    username
  end
  def self.check_username(username)
    user = self.find_by_username(username)
  end
  def self.repository(username)
    repository = HTTParty.get("https://api.github.com/users/#{username}/repos")
    repo = Array.new
    repository.each_with_index do |i,j|
      repo.push({:name => i["name"], :id => i["id"]})
    end
    return repo
  end
end
