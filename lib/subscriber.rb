require 'redis'

class Subscriber
  def initialize sse
    @sse = sse
  end

  def subscribe channel
    r = Redis.new
    r.subscribe channel do |on|
      on.message do |channel, message|
        @sse.write({time: Time.now, channel: channel, message: message})
      end
    end
  end
end
