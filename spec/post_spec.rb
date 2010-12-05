require 'posterous-ruby'
require 'spec_helper'
describe Posterous do

  describe "Posterous#log_as" do
    context "valid login" do
      it "should return a user session" do
        session = Posterous.login_as('user_name','password')
        session.should be_instance_of(Posterous::Session)
      end
    end
  end

end
