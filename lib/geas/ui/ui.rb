require "curses"
require "yaml"

module Geas
  module Defaults
    LAYOUT = File.join(__dir__, "..", "defaults", "layout.yaml")
  end

  module UI
    @views = {}

    def self.views
      @views
    end

    def self.view(key)
      @views[key.to_sym]
    end

    def self.link(layout: Defaults::LAYOUT)
      begin
        UI.setup(layout: YAML.load_file(layout).symbolize)
      ensure
        UI.teardown()
      end
    end

    def self.setup(**opts)
      Curses.init_screen()
      UI.draw(**opts)
      Curses.start_color()
      Curses.cbreak()
      Curses.noecho()
      UI.event_loop()
    end

    def self.draw(**opts)
      opts.fetch(:layout).each_pair do |name, opts|
        opts= opts.symbolize
        @views[name] = case name
        when :left_hand, :right_hand, :main
          puts(name)
          TextPane.new(**opts)
        when :prompt
          Input.new(**opts)
        when :hud

        else 
          raise Exception.new <<~ERROR
            unknown window of #{name}
          ERROR
        end
      end
    end

    def self.teardown()
      Curses.close_screen()
    end

    def self.validate_percent(percent)
      raise Exception.new(%{#{percent} must be between 0-1}) if percent > 1 or percent < 0
    end

    def self.percent_width(percent)
      validate_percent(percent)
      Curses.cols * percent
    end

    def self.percent_height(percent)
      validate_percent(percent)
      Curses.lines * percent
    end

    def self.event_loop()
      #Curses.doupdate
      loop do sleep(1) end
    end
  end
end