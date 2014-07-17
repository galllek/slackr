require 'spec_helper'

describe Slackr::UserData do
  before do
    @connection = Slackr::Connection.new("team", "token", {})
    @connection.send(:setup_connection)
    
    stub_request(:get, "http://team.slack.com:443/api/users.list?token=token").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => '{
          "members": [
        {
            "id": " EXAMPLE_ID",
            "profile": {
                "email": "example_email@example.com"
            }
        }
          ]}', :headers => {})

                
  end

context "Public API" do
  
  describe "#get_user_email" do
    it "should return email address" do
      id = 'U034CJ88'
      result = Slackr::UserData.get_user_email(@connection, id.to_s)
      expect(result).to eq "example_email@example.com"
      end
    end
end

context "Private API" do
  
  describe "#api_url" do
    it "generates the right url" do
      service = 'users.list'
      subject.instance_variable_set(:@connection, @connection)
      result = subject.send(:api_url, service, {})
      expect(result).to eq "https://team.slack.com/api/users.list?token=token"
      end
  end
end
end

