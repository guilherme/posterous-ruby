require 'json'
require 'net/http'
require File.dirname(__FILE__) + "/posterous-ruby/session"
require File.dirname(__FILE__) + "/posterous-ruby/user"
require 'crack'
module Posterous


  def self.login_as(user_name,password)
    Session.new(user_name,password)
  end


end

