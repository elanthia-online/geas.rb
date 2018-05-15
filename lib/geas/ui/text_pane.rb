require "curses"


class TextPane < Curses::Window  
  attr_reader :feed

	def initialize(**opts)
		@feed = Feed.new()
		super(opts[:height], opts[:width], opts[:top], opts[:left])
		if opts[:height] > 1 and opts[:width] > 1
			scrollok(true)
		end
  end
	
	def put(line)
		@feed.rpush(line)
		addstr(line)
	end
end