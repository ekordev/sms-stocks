class ParsingUtils
  NO_FROM_TEXT = "Please pass 'From' parameter or use SMS"
  def self.get_stock_tickers(text)
    return nil if text.blank?
    arr_tickers = text.split(/[\s,'.:;]/)
    arr_clean_tickers = []
    arr_tickers.each do |ticker|
      ticker.strip!
      arr_clean_tickers<<ticker.upcase if !ticker.blank?
    end
    return nil if arr_clean_tickers.length==0
    return arr_clean_tickers
  end

  def self.array_to_readable(arr)
    str_ret = ''
    arr.each_with_index do |item,index|
      str_ret << item
      str_ret << ', ' if index!=arr.length-1
    end
    return str_ret
  end

  def self.generate_stocks_text(arr_stocks)
    ret_text = ''
    arr_stocks.each do |stock_data|
      if stock_data[:price]==0
        ret_text<<"No data found for symbol: #{stock_data[:symbol]}\n"
      else
        ret_text<<"Symbol: #{stock_data[:symbol]}, price: #{stock_data[:price]}\n"
      end
    end
    return ret_text
  end

  def self.get_no_from_message
    return NO_FROM_TEXT
  end
end