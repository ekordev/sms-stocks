class Users < ActiveRecord::Base
  require 'json'
  after_initialize :custom_init

  def subscribed_tickers_arr
    if(@subscribed_tickers_arr_cache == 0)
      if !subscribed_tickers.blank?
        @subscribed_tickers_arr_cache = JSON.parse(subscribed_tickers)
      else
        @subscribed_tickers_arr_cache = nil
      end
    end
    return @subscribed_tickers_arr_cache
  end

  private
    def custom_init
      @subscribed_tickers_arr_cache = 0
    end
end