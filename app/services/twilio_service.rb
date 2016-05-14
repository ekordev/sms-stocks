class TwilioService
  require 'twilio-ruby'
  @account_sid = "ACe95bacf294dacae38faab45376867f44" # Your Account SID from www.twilio.com/console
  @auth_token = "a51d63d3a949926fa065ddcda003d672"   # Your Auth Token from www.twilio.com/console
  @my_num = "+14088161047"

  def self.generate_response(message)
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message message
    end
    return twiml.text
  end

  def self.send_message(to,text)
    begin
      @client = Twilio::REST::Client.new @account_sid, @auth_token
      message = @client.account.messages.create(:body => text, :to => to,:from => @my_num)
    rescue Twilio::REST::RequestError => e
        puts e.message
    end
 end
end