require 'posterous-ruby'
require 'spec_helper'
describe Posterous::Posterous do

  describe "#initialize" do
    it "should receive user_name and password as argument"  do
      posterous = Posterous::Posterous.new("user_name","password")
      posterous.user_name.should == "user_name"
      posterous.password.should == "password"
    end
  end
  

  describe "#request_token!" do
    context "valid user_name/password" do
      before(:all) do 
        @user_name = "invalid"
        @password  = "password"
        @posterous = Posterous::Posterous.new(@user_name,@password)
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
        @posterous = Posterous::Posterous.new(@user_name,@password)
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


end
