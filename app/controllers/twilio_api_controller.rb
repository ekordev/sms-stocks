class TwilioApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'twilio-ruby'
  def sms
    message = SmsRequestService.get_data(params)
    puts params.inspect
    puts message
    render xml: TwilioService.generate_response(message)
  end
end