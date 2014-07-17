require 'net/http'
require 'net/https'
require 'uri'
require 'json'
  
module Slackr
  module UserData
    extend self
    
    attr_accessor :connection
    
     def get_user_email(connection, id)
      @connection = connection
      email = ""
      uri = URI.parse(api_url('users.list'))
      http = Net::HTTP.new(uri.host, 443)
      http.use_ssl = true
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
      if response.code != "200"
        raise Slackr::ServiceError, "Slack.com - #{response.code} - #{response.body}"
      else
        users = JSON.parse(response.body)["members"]
        users.select {|user| id.to_s == user["id"]
        email = user["profile"]["email"]}
      end
      email
    end
    
    private
    #To-DO: add options in url
    def api_url(service, options = {})
      "#{connection.base_url}/api/#{service}?token=#{connection.token}"
    end
  end
end


      
