#ActiveSupport::Notifications.subscribe do |name, start, finish, id, payload|  
#  Rails.logger.info(["notification:", name, start, finish, id, payload].join(" "))  
#end

ActiveSupport::Notifications.subscribe "users.login" do |name, start, finish, id, payload|  
  METRICS.increment('users.login')
end
