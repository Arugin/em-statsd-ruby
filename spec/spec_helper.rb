require 'simplecov'
SimpleCov.start

require 'coveralls'
Coveralls.wear!

require 'em-statsd-ruby'
require 'rspec'
require 'logger'

class FakeUDPSocket
  def initialize
    @buffer = []
  end

  def write(message)
    @buffer.push [message]
    message.length
  end

  def recv
    @buffer.shift
  end

  def clear
    @buffer = []
  end

  def to_s
    inspect
  end

  def inspect
    "<#{self.class.name}: #{@buffer.inspect}>"
  end
end

class FakeTCPSocket < FakeUDPSocket
  alias_method :readline, :recv
  def write(message)
    @buffer.push message
  end
end