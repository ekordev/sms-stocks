class TwilioApiController < ApplicationController
  require 'twilio-ruby'
  def sms
    ticker = params['ticker']
    status = "OK"
    is_success, stock_price = StockService.get_price(ticker)
    if !is_success
      status = "ERROR"
      stock_price=0
    end
    #render :json =>
    #  {
    #    "status" => status,
    #    "price": stock_price
    #  },
    #  status: 200
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Price for stock symbol: #{ticker} is: #{stock_price}"
    end
    twiml.text
  end
end