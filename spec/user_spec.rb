require 'spec_helper'
require 'posterous-ruby'

describe Posterous::User do

  include UserHelper

  describe "#find" do

    before(:each) do 
     @user_name = "user_name"
     @password  = "password"
     @session   = Posterous::Session.new(@user_name,@password)
     @session.stub!(:api_token).and_return("authenticated")
     FakeWeb.register_uri(:get, "http://#{@user_name}:#{@password}@posterous.com/api/2/users/me?api_token=#{@session.api_token}", :body =>  JSON.generate(valid_user_attrs) )
    end
    it "should  return an instance of User" do
      user = Posterous::User.find('me', @session)
      user.should be_instance_of(Posterous::User)
    end

    it "should retrieve the user with 'user_name'" do
      user = Posterous::User.find('me', @session)
      user.nickname.should == "kbsa"
    end

    after(:each) do
      FakeWeb.clean_registry
    end

  end

end
