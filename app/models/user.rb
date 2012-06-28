class User < ActiveRecord::Base
  attr_accessible :token, :username
end
