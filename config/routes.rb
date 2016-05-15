Rails.application.routes.draw do
  match '/twilio' => 'twilio_api#sms' , via: [:get, :post]

  get '/users/all' => 'users_api#get_users'
  get '/users/notify' => 'users_api#notify_subscribers'

  match '/stocks/subscribe' => 'stocks_api#subscribe' , via: [:get, :post]
  match '/stocks/unsubscribe' => 'stocks_api#unsubscribe' , via: [:get, :post]
  match '/stocks/price' => 'stocks_api#price' , via: [:get, :post]
  match '/stocks/more' => 'stocks_api#more' , via: [:get, :post]
end
