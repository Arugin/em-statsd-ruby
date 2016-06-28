module EventMachine
  class Statsd< ::Statsd

    def connect
      @s_mu.synchronize do
        begin
          @socket.close if @socket
        rescue
          self.class.logger.error { 'Statsd: can not close connection' } if self.class.logger
        end

        case @protocol
          when :tcp
            @socket = EMStatsd::TCPWrapper.new host, port
          else
            @socket = EMStatsd::UDPWrapper.new host, port
        end
      end
    end

    def send_to_socket(message)
      socket.write(message)
    rescue => boom
      self.class.logger.error { "Statsd: #{boom.class} #{boom}" } if self.class.logger
      nil
    end

  end

end
