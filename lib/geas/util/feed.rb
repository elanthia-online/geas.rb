class Feed
  attr_accessor :max_size, :members
  include Enumerable

  def initialize(**opts)
    @max_size = opts.fetch(:max_size, 200)
    @members  = []
  end

  def each()
    @members.each do |member|
      yield member
    end
  end

  def rpush(ele)
    @members << ele
    lpop() while overflow?
    self
  end

  def size
    @members.size
  end

  def overflow?
    size < @max_size
  end

  def lpop(ele)
    @members.shift
  end
end
