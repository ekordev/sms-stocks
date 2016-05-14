class SmsRequestService

  def self.get_last_stock(phone_num)
    return @@cache.fetch(phone_num)
  end

  def self.get_stock_more_info(ticker)
    stock = StockService.get_more_info(ticker)
    ret_text = "Info for stock: #{ticker}, open: #{stock[:open]}, high: #{stock[:high]},"\
                "previous close: #{stock[:previous_close]}, book value: #{stock[:book_value]}"
    return ret_text
  end

  def self.get_stocks_price(stocks, from)
    if !from.blank?
      user = Users.find_by_phone_num(from) || Users.create(:phone_num => from)
      user.last_ticker = stocks[0]
      user.save
    end
    arr_stocks_data = StockService.get_price(stocks)
    ret_text = ParsingUtils.generate_stocks_text(arr_stocks_data)
    return ret_text
  end

  def self.get_data(params)
    text_body = params['Body']
    ret_data = ''
    if text_body.blank? || text_body=="?" || text_body=="help"
      ret_data = "Usage: ticker, tickers, more info\nMore to come, stay tuned..."
    elsif text_body.downcase=="more info"
      user = Users.find_by_phone_num(params['From'])
      if user.nil? || user.last_ticker.nil?
        ret_data = "No ticker fround for 'more info' command, please send a ticker inquery prior to this command"
      else
        ret_data = self.get_stock_more_info(user.last_ticker)
      end
    elsif text_body.downcase.include? "subscribe"
      if params['From'].blank?
        ret_data = "Cannot identify your phone numbers, please use SMS"
      else
        ret_data = SubscriptionService.subscribe(text_body,params['From'])
      end
    else
      arr_stocks = ParsingUtils.get_stock_tickers(text_body)
      if arr_stocks.nil?
        ret_data = "No stock symbols found"
      else
        ret_data = self.get_stocks_price(arr_stocks,params['From'])
      end
    end

    return ret_data
  end
end