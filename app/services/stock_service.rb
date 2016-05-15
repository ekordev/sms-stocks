class StockService

  def self.more_info(from)
    return ParsingUtils.get_no_from_message if from.blank?
    user = Users.find_by_phone_num(from)
    if user.nil? || user.last_ticker.nil?
      ret_data = "No ticker fround for 'more info' command, please send a ticker inquery prior to this command"
    else
      ret_data = self.get_stock_more_info(user.last_ticker)
    end
    return ret_data
  end

  def self.get_stocks_data(text_body,from)
    arr_stocks = ParsingUtils.get_stock_tickers(text_body)
    if arr_stocks.nil?
      ret_data = "No stock symbols found"
    else
      ret_data = self.get_stocks_price(arr_stocks,from)
    end
  end

  private
    def self.get_stock_more_info(ticker)
      stock = StockCoreService.get_more_info(ticker)
      ret_text = "Info for stock: #{stock[:symbol]}, open: #{stock[:open]}, high: #{stock[:high]},"\
                  "previous close: #{stock[:previous_close]}, book value: #{stock[:book_value]}"
      return ret_text
    end

    #save one of valid tickers for this user to support more info command
    def self.save_first_valid_stock(arr_stocks, from)
      if !from.blank?
        user = Users.find_by_phone_num(from) || Users.create(:phone_num => from)
        arr_stocks.each do |stock|
          if stock[:price]!=0
            user.last_ticker = stock[:symbol]
            user.save
            return
          end
        end
      end
    end

    def self.get_stocks_price(stocks, from)
      arr_stocks_data = StockCoreService.get_price(stocks)
      self.save_first_valid_stock(arr_stocks_data,from)
      ret_text = ParsingUtils.generate_stocks_text(arr_stocks_data)
      return ret_text
    end
end