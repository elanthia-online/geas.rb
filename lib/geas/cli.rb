require "thor"
require "geas"

module Geas
  class CLI < Thor
    no_commands do
      def debug?
        options[:debug]
      end
    end

    desc("connect", 
      "connects to a character on the given port")
    option(:character, 
      required: true, 
      type: :string)
    option(:port,
      default: 8080)
    option(:host,
      default: "127.0.0.1")
    option(:debug,
      default: false,
      type: :boolean)
    def connect()
      System.log(options.inspect) if debug?
      Geas::link(**Hash[options.map do |key, val| 
        [key.to_sym, val] 
      end])
    end
  end
end