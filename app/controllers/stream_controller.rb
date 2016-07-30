class StreamController < ApplicationController
  include ActionController::Live

  def stream_listen
    response.headers['Content-Type'] = 'text/event-stream'
    10.times {
      response.stream.write 'Testing.'
      sleep(1.0/24.0)
    }
  ensure
    response.stream.close
  end
end
