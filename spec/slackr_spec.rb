require 'spec_helper'

describe Slackr do
  describe "#say" do
    it "should delegate to the IncomingWebhook" do
      subject = Slackr.connect("foo", "bar", {"channel" => "#general", "username" => "baz"})
      expect(Slackr::IncomingWebhook).to receive(:say)
      subject.say("hello world", {})
    end
  end
  
  describe "#get_user_email" do
    it "should delegate to the UserData" do
      subject = Slackr.connect("foo", "bar")
      expect(Slackr::UserData).to receive(:get_user_email)
      subject.get_user_email("Xthaha55a")
    end
  end
    
    
  describe "Webook.new" do
    before do
      @orig_stderr = $stderr
      $stderr = StringIO.new
    end

    it "should raise a deprecation warning" do
      Slackr::Webhook.new("team", "token")
      $stderr.rewind
      $stderr.string.chomp.should match(/^\[DEPRECATION\]/)
    end

    after do
      $stderr = @orig_stderr
    end
  end
end

