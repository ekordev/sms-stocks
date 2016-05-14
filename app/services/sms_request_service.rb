class SmsRequestService
  @@cache = ActiveSupport::Cache::MemoryStore.new
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
    @@cache.write(from,stocks[0])
    arr_stocks_data = StockService.get_price(stocks)
    ret_text = ''
    arr_stocks_data.each do |stock_data|
      ret_text<<"Symbol: #{stock_data[:symbol]}, price: #{stock_data[:price]}\n"
    end
    return ret_text
  end

  def self.get_data(params)
    text_body = params['Body']
    ret_data = ''
    if text_body.downcase=="more info"
      ticker = get_last_stock(params['From'])
      if ticker.blank?
        ret_data = "No ticker fround for 'more info' command, please send a ticker inquery prior to this command"
      else
        ret_data = self.get_stock_more_info(ticker)
      end
    elsif text_body.include? ' '
      arr_stocks = text_body.split(' ')
      ret_data = self.get_stocks_price(arr_stocks,params['From'])
    elsif text_body.include? ','
      arr_stocks = text_body.split(',')
      ret_data = self.get_stocks_price(arr_stocks,params['From'])
    else
      ret_data = self.get_stocks_price([text_body],params['From'])
    end

    return ret_data
  end
end