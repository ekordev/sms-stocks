require 'twilio-ruby'

account_sid = "ACe95bacf294dacae38faab45376867f44" # Your Account SID from www.twilio.com/console
auth_token = "a51d63d3a949926fa065ddcda003d672"   # Your Auth Token from www.twilio.com/console

#begin
#  @client = Twilio::REST::Client.new account_sid, auth_token
#  message = @client.account.messages.create(:body => "Hello from Ruby",
#      :to => "+14086676500",    # Replace with your phone number
#      :from => "+14088161047")  # Replace with your Twilio number
#  rescue Twilio::REST::RequestError => e
#    puts e.message
#  end
#puts message.sid

#@client = Twilio::REST::Client.new account_sid, auth_token
#@app = @client.account.applications.get("stocks")
#@app.update(:sms_url => "http://demo.twilio.com/docs/sms.xml")
#puts @app.voice_url