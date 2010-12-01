require 'crack'
module Posterous
  class AuthenticationFailure < StandardError; end
  class Posterous

    attr_accessor :user_name,:password
    attr_reader :api_token

    def initialize(user_name,password)
      @user_name = user_name
      @password  = password
    end

    def authenticate!
      Net::HTTP.start("posterous.com") do |http|
        req = Net::HTTP::Get.new("/api/2/auth/token")
        req.basic_auth(user_name,password)
        response = http.request(req)
        response = Crack::JSON.parse(response.body)
        raise AuthenticationFailure if response["error"] == "Unauthorized"
        self.api_token = response["api_token"]
      end
    end


    private

    attr_writer :api_token


  end



end
