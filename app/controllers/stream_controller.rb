class StreamController < ApplicationController
  include ActionController::Live

  def stream_listen
    return head 404 unless params[:id]
    response.headers['Content-Type'] = 'text/event-stream'
    # blocks the current thread
    # Stream is on a background thread and will remain open until redis.psubscribe exits.
    redis = Redis.new
    redis.psubscribe("#{params[:id]}:*") do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("Event: #{event}\n")
        response.stream.write("Data: #{data}\n\n")
      end
    end
  rescue IOError
    # Client disconnect
  ensure
    redis.quit
    response.stream.close
  end

  def broadcast
    redis = Redis.new
    redis.publish("#{params[:id]}:#{params[:packet_number]}", 'Test')
  end
end
