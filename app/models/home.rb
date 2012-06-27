class Home < ActiveRecord::Base
  include HTTParty
  # attr_accessible :title, :body
  def self.token(code)#retrieve access token
    token = HTTParty.post("https://github.com/login/oauth/access_token?client_id=81e06b06df8444dfc400&client_secret=c29601141049ed316792c017d26fde2354ef530b&redirect_url=localhost:3000&code=#{code}")
    token = token.parsed_response
    token = token.split("=")
    token = token[1].split("&")
    token = token[0]
    if token = self.find_by_token(token)
      return token.token
    else
      self.token = token
      self.save
      return token
    end

  end
  def self.user_details(token)#
    user_details = HTTParty.get("https://api.github.com/user?access_token=#{token}")
    user_details =  user_details.parsed_response
  end

end
