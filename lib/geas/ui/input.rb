module Geas
  class Input < Curses::Window
    attr_reader :buffer, :text
    def initialize(**opts)
      @buffer = Feed.new()
      @text   = ""
      @input  = Thread.new do
        loop do
          redraw(self.getch)
        end
      end
      super(opts[:height], opts[:width], opts[:top], opts[:left])
      scrollok(false)
      keypad(true)
    end

    def flush()
      @text = ""
      noutrefresh
    end

    def append(text)
      @text = @text + text
      noutrefresh
    end
  end
end