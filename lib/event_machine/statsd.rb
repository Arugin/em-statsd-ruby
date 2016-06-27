require 'eventmachine'

require 'event_machine/statsd/udp_wrapper'
require 'event_machine/statsd/tcp_wrapper'

module EventMachine
  class Statsd < ::Statsd

    def connect
      @s_mu.synchronize do
        begin
          @socket.close if @socket
        rescue
          # Errors are ignored on reconnects.
        end

        case @protocol
          when :tcp
            @socket = EventMachine::Statsd::TCPWrapper.new @host, @port
          else
            @socket = EventMachine::Statsd::UDPWrapper.new @host, @port
        end
      end
    end

    protected

    def send_to_socket(message)
      socket.write(message)
    rescue => boom
      self.class.logger.error { "Statsd: #{boom.class} #{boom}" } if self.class.logger
      nil
    end

  end
end
