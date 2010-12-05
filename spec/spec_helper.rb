require 'fakeweb'

RSpec.configure do |config|
  config.before(:suite) do
    FakeWeb.allow_net_connect = false
  end
  config.after(:suite) do
    FakeWeb.allow_net_connect = true
  end
end


module UserHelper

  def valid_user_attrs 
    {
      "id"            => '1234',
      "firstname"     => "Guilherme",
      "lastname"      => "Reis",
      "nickname"      => "kbsa",
      "profile_pic"   => "",
      "last_activity" => "2010/12/05 02:58:21 -0300"
    }
  end

end
