class SubscriptionService
  require 'json'
  def self.get_tickers(text_body)
    text_body.gsub!(/(subscribe)/i,'')
    arr_stocks = ParsingUtils.get_stock_tickers(text_body)
  end

  def self.subscribe(text_body,phone)
    user = Users.find_by_phone_num(phone) || Users.create(:phone_num => phone)
    tickers = self.get_tickers(text_body)
    tickers = StockService.get_valid_tickers(tickers) if !tickers.nil?
    ret_text = ''
    if tickers.nil? || tickers.length==0
      ret_text = 'Cannot find any valid stock symbols to subscribe'
    else
      user.subscribed_tickers = tickers
      user.save
      ret_text = "Successfully subscribed for: #{ParsingUtils.array_to_readable(tickers)}"
    end
    return ret_text
  end

  def self.notify_users(users,arr_stocks)
    set_stocks = {}
    arr_stocks.each do |stock|
      set_stocks[stock[:symbol]] = stock
    end

    users.each do |user|
      stocks_per_user = []
      user.subscribed_tickers_arr.each do |ticker|
        stocks_per_user << set_stocks[ticker]
      end
      message = ParsingUtils.generate_stocks_text(stocks_per_user)
      TwilioService.send_message(user.phone_num,message)
    end
  end

  def self.notify_subscribers
    tickers_set = Set.new
    users_to_notify = []
    users = Users.all
    users.each do |user|
      if !user.subscribed_tickers_arr.nil?
        puts "here"
        users_to_notify << user
        user.subscribed_tickers_arr.each do |ticker|
          tickers_set << ticker
        end
      end
    end

    arr_tickers = tickers_set.to_a
    return nil if tickers_set.length==0 || users_to_notify.length == 0

    arr_stocks = StockService.get_price(arr_tickers)
    self.notify_users(users_to_notify,arr_stocks)
    return users
  end
end