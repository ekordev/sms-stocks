desc "This task is called by the Heroku scheduler add-on"
task :notify_subscribers => :environment do
  puts "notify_subscribers..."
  SubscriptionService.notify_subscribers
  puts "notify_subscribers done."
end