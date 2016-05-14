class StockService
  require 'open-uri'
  require 'rubygems'
  require 'json'

  def self.get_stock_json(stock)
    return {
      :price  => stock.ask || 0,
      :symbol => stock.symbol
    }
  end

  def self.get_price(ticker)
    return nil if ticker.blank?
    stocks = StockQuote::Stock.quote(ticker)
    ret = []
    if stocks.kind_of?(Array)
      stocks.each do |stock|
        ret << self.get_stock_json(stock)
      end
    else
      ret << self.get_stock_json(stocks)
    end
    return ret
  end

  def self.get_more_info(ticker)
    stock = StockQuote::Stock.quote(ticker)
    return {
      :open => stock.open,
      :high => stock.high,
      :previous_close => stock.previous_close,
      :book_value => stock.book_value
    }
  end

  def self.get_valid_tickers(tickers)
    stocks = self.get_price(tickers)
    arr_valid = []
    stocks.each do |stock|
      arr_valid<<stock[:symbol] if stock[:price]!=0
    end
    return arr_valid
  end
end