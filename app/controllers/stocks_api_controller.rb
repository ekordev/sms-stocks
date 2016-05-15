class StocksApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def subscribe
    ret_text = SubscriptionService.subscribe(params['Body'],params['From'])
    render text: ret_text
  end

  def unsubscribe
    ret_text = SubscriptionService.unsubscribe(params['From'])
    render text: ret_text
  end

  def price
    ret_text = StockService.get_stocks_data(params['Body'],params['From'])
    render text: ret_text
  end

  def more
    ret_text = StockService.more_info(params['From'])
    render text: ret_text
  end
end