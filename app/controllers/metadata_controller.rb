require 'subscriber'

class MetadataController < ApplicationController
  include ActionController::Live
  def index
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)
    begin
      loop {
        # blocking redis subscriber
        Subscriber.new(sse).subscribe :metadata
      }
    rescue IOError
    ensure
      sse.close
    end
  end
end
