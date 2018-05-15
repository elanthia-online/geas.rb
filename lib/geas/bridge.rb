require "socket"

module Geas
  class Bridge
    def self.link(*args)
      new(*args)
    end

    attr_reader :sock, :reader, :parser

    def initialize(**opts)
      @sock   = TCPSocket.open(opts.fetch(:host), opts.fetch(:port))
      @reader = consume()
    end

    def consume()
      Thread.new do
        @parser = Parser.new([Geas::Stream])
        while (incoming = @sock.gets)
          @parser.puts(incoming)
        end
      end
    end
  end
end