class TwilioApiController < ApplicationController
  require 'twilio-ruby'

  def sms
    message = SmsRequestService.get_data(params)
    puts params.inspect
    puts message
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message message
    end
    render xml: twiml.text
  end
end