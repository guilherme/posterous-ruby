require 'spec_helper'
require 'posterous-ruby'

describe Posterous::Session do
    
  describe "#initialize" do
    before(:all) do
      @user_name = 'user_name'
      @password  = 'password'
    end

    it "should receive user_name and password" do
      session = Posterous::Session.new(@user_name,@password)
      session.user_name.should == @user_name
      session.password.should  == @password
    end

  end

  describe "#request_token!" do
    context "valid user_name/password" do
      before(:all) do 
        @user_name = "invalid"
        @password  = "password"
        @posterous = Posterous::Session.new(@user_name,@password)
        FakeWeb.register_uri(:get, "http://#{@user_name}:#{@password}@posterous.com/api/2/auth/token", :body => '{"api_token": "authenticated"}')
      end
      it "should load api_token" do 
        @posterous.request_token!
        @posterous.api_token.should == "authenticated"
      end
      after(:all) do
        FakeWeb.clean_registry
      end
    end
    
    context "invalid user_name/password" do
      before(:all) do 
        @user_name = "invalid"
        @password  = "password"
        @posterous = Posterous::Session.new(@user_name,@password)
        FakeWeb.register_uri(:get, "http://#{@user_name}:#{@password}@posterous.com/api/2/auth/token", :body => '{"error":"Unauthorized"}')
      end
      it "should raise an Posterous::AuthenticationFailure exception when user_name/password is invalid" do
        lambda { @posterous.request_token! }.should raise_exception(Posterous::AuthenticationFailure)
      end
      after(:all) do
        FakeWeb.clean_registry
      end
    end
  end

  describe "#user" do
    before(:all) do
      @session = Posterous::Session.new('user_name','password')
    end

    it "should find a Posterous::User" do
      Posterous::User.should_receive(:find).with('me', @session)
      @session.user
    end
  end


end
  

