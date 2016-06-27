require 'spec_helper'

shared_examples_for 'a statsd' do

  describe '#increment' do

    it 'formats the message according to the statsd spec' do
      em_statsd.increment('foobar')
      expect(socket.recv).to eq ['foobar:1|c']
    end

  end

end

describe EM::Statsd do
  before do
    class EMStatsd::UDPWrapper
      o, $VERBOSE = $VERBOSE, nil
      alias initialize_old initialize
      def initialize(*args)

      end
      $VERBOSE = o
    end

    class EMStatsd::TCPWrapper
      o, $VERBOSE = $VERBOSE, nil
      alias initialize_old initialize
      def initialize(*args)

      end
      $VERBOSE = o
    end
  end

  after do
    class EMStatsd::UDPWrapper
      o, $VERBOSE = $VERBOSE, nil
      alias initialize initialize_old
      $VERBOSE = o
    end

    class EMStatsd::TCPWrapper
      o, $VERBOSE = $VERBOSE, nil
      alias initialize initialize_old
      $VERBOSE = o
    end
  end

  subject(:em_statsd) { EM::Statsd.new('localhost', 1234) }


  let(:tcp_socket) { FakeTCPSocket.new }

  before do
    allow_any_instance_of(EMStatsd::TCPWrapper).to receive(:connection).and_return(tcp_socket)
  end

  describe '#initialize' do
    it 'sets the host and port' do
      expect(em_statsd.host).to eq 'localhost'
      expect(em_statsd.port).to eq 1234
    end

    it 'sets default the host to 127.0.0.1 and port to 8125' do
      statsd = EM::Statsd.new
      expect(statsd.host).to eq '127.0.0.1'
      expect(statsd.port).to eq 8125
    end

    it 'should set delimiter to period by default' do
      expect(em_statsd.delimiter).to eq '.'
    end
  end

  context 'when udp' do
    let(:socket) { FakeUDPSocket.new }

    before { allow_any_instance_of(EMStatsd::UDPWrapper).to receive(:connection).and_return(socket) }

    it_behaves_like 'a statsd'
  end

  context 'when tcp' do
    subject(:em_statsd) { EM::Statsd.new('localhost', 1234, :tcp) }

    let(:socket) { FakeTCPSocket.new }

    before { allow_any_instance_of(EMStatsd::TCPWrapper).to receive(:connection).and_return(socket) }

    it_behaves_like 'a statsd'
  end

end


