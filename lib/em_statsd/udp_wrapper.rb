module EMStatsd
  class UDPWrapper < BaseWrapper

    attr_reader :connection

    def initialize(host, port)
      @host, @port = host, port
      # eventmachine forces us to listen on a UDP socket even
      # though we only
      # want to send, so we'll just give it a junk address
      @connection = EM.open_datagram_socket('0.0.0.0', 0, EM::Connection)
    end

    def close
      connection.close_connection_after_writing
    end

    def flush

    end

    def write(message)
      connection.send_datagram(message, @host, @port)
    end

  end
end
