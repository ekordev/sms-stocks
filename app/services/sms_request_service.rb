class SmsRequestService
  def self.get_data(params)
    text_body = params['Body']
    ret_data = ''
    if text_body.blank? || text_body=="?" || text_body=="help"
      ret_data = "Usage: ticker, tickers, more info, subscribe, unsubscribe\nMore to come, stay tuned..."
    elsif text_body.downcase=="more info"
      ret_data = StockService.more_info(params['From'])
    elsif text_body.downcase.include? "unsub"
      ret_data = SubscriptionService.unsubscribe(params['From'])
    elsif text_body.downcase.include? "subscribe"
        ret_data = SubscriptionService.subscribe(text_body,params['From'])
    else
      ret_data = StockService.get_stocks_data(text_body,params['From'])
    end

    return ret_data
  end
end