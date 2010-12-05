module Posterous
  class User
    
    attr_accessor :id,:firstname,:lastname,:nickname,:profile_pic,:last_activity, :sites

    def self.find(user_name,session)
      session.request_token! unless session.api_token
      Net::HTTP.start("posterous.com") do |http|
        request = Net::HTTP::Get.new("/api/2/users/#{user_name}?api_token=#{session.api_token}")
        request.basic_auth(session.user_name,session.password)
        response = http.request(request)
        response = Crack::JSON.parse(response.body)
        raise AuthenticationFailure if response["error"] == "Unauthorized"
        User.new(response)
      end
    end

    def initialize(attributes = {})
      attributes.each do |k,v|
        self.send("#{k}=".to_sym,v)
      end
    end
      
  end
end
