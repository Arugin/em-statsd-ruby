module EMStatsd
  class TCPWrapper < BaseWrapper

    attr_reader :connection

    def initialize(host, port)
      # eventmachine forces us to listen on a UDP socket even
      # though we only
      # want to send, so we'll just give it a junk address
      @connection = EM.connect(host, port, EM::Connection)
    end

    def close
      connection.close_connection_after_writing
    end

    def flush

    end

    def write(message)
      connection.send_data(message)
    end

  end
end
