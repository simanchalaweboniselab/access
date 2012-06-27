class HomeController < ApplicationController
  respond_to :json
  def index
  end
  #DONE retrieve access token
  def access_token
    #client = OAuth2::Client.new("81e06b06df8444dfc400", "c29601141049ed316792c017d26fde2354ef530b", :site => 'https://github.com')
    #logger.info"+=====================================================================#{client.inspect}"
    #@url=client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth/callback')
    #logger.info"+=====================================================================#{params[:code]}"
    #token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000')
    #logger.info"+=====================================================================#{token.inspect}"
    #response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
    #response.class.name
    #logger.info"===================================================================#{params.inspect}"
    ##response = HTTParty.get("https://github.com/login/oauth/authorize?client_id=81e06b06df8444dfc400")
    ##logger.info "===================================================================#{response.methods}"
    #token = HTTParty.post('https://github.com/login/oauth/access_token??client_id=81e06b06df8444dfc400&client_secret=c29601141049ed316792c017d26fde2354ef530b&redirect_url=localhost:3000&code=76456e6706e82bdb7645')
    #logger.info"=============================================#{token.inspect}"
    #respond_with do |format|
    #  format.json {render :json => {:success => true }}
    #end
    token = Home.token(params[:code])
    username = Home.user_details(token)
    repository = Home.repository(username)
    respond_with do |format|
      format.json {render :json => {:success => true, :auth_token => token, :username => username, :repository => repository }}
    end
  end
  def auth_token
    if user=Home.check_username(params[:username])
      repository = Home.repository(params[:username])
      respond_with do |format|
        format.json {render :json => {:success => true, :auth_token => user.token, :username => user.username, :repository => repository }}
      end
    else
      respond_with do |format|
        format.json {render :json => {:success => false}}
      end
    end
  end
  #def repo
  #  username = "simanchalaweboniselab"
  #  repository = Home.repository(username)
  #  respond_with do |format|
  #    format.json {render :json => {:success => true, :data => repository }}
  #  end
  #end
end


