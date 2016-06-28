module EMStatsd
  class BaseWrapper

    attr_reader :connection

    def close
      connection.close_connection_after_writing
    end

    def flush

    end

    def write(_)

    end

  end
end

