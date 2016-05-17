class UsersApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def get_users
    users = Users.all
    render :json => users,
      status: 200
  end

  def notify_subscribers
    users = SubscriptionService.notify_subscribers
    render :json => {
      "message" => users.nil? ? "No subscribers to notify" : "All subscribed users have been notified",
      "users" => !users.nil? ? users : "no users"
      }, status: 200
  end
end