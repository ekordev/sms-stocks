class StockService
  require 'open-uri'
  require 'rubygems'
  require 'json'
  GOOGLE_STOCKS_API = 'http://www.google.com/finance/info?q='

  def self.get_price(ticker)
    #raw_data = open(GOOGLE_STOCKS_API+ticker)
    #stock_json_data = JSON.load(raw_data)
    stock = StockQuote::Stock.quote(ticker)
    return !stock.ask.nil?,stock.ask
  end
end