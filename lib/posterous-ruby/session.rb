module Posterous

  class AuthenticationFailure < StandardError; end
  
  class Session

    attr_accessor :user_name, :password

    attr_reader :api_token

    def initialize(user_name,password)
      self.user_name = user_name
      self.password  = password
    end

    def request_token!
      Net::HTTP.start("posterous.com") do |http|
        req = Net::HTTP::Get.new("/api/2/auth/token")
        req.basic_auth(user_name,password)
        response = http.request(req)
        response = Crack::JSON.parse(response.body)
        raise AuthenticationFailure if response["error"] == "Unauthorized"
        self.api_token = response["api_token"]
      end
    end

    def user
      User.find('me', self)
    end


    private

    attr_writer :api_token
  end

end
