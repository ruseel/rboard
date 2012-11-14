def max(bit_size)
  2 ** bit_size - 1
end

#
# Immutable pattern
#
class Boardish
  attr_accessor :parts
  attr_reader :raw
  BIT_SIZE = 3
  DEPTH_SPEC = [23, BIT_SIZE, BIT_SIZE]
  DEFAULT_VALUES = [0, max(BIT_SIZE), max(BIT_SIZE)]

  def initialize(i)
    self.raw = i
  end

  def raw=(i)
    if i
      a = i >> (BIT_SIZE*2)
      b = (i & 0b111111) >> BIT_SIZE
      c = (i & 0b111)

      @parts = [a, b, c]
    else
      @parts = DEFAULT_VALUES
    end
  end

  def raw
    to_i
  end

  def inc_at_depth(depth)
    self.class.from_array(parts).tap do |n|
      step = (depth==0) ? 1 : -1
      n.parts[depth] += step
    end
  end

  def depth
    n = max_depth - 1
    while n > 0
      if @parts[n] != DEFAULT_VALUES[n]
        break
      end
      n -= 1
    end
    n
  end

  def reply
    _new_depth=depth+1
    if _new_depth < max_depth
      inc_at_depth(_new_depth)
    else
      inc_at_depth(depth)
    end
  end

  def max_depth
    @parts.size
  end

  def to_i
    a = parts[0] << (BIT_SIZE*2)
    b = parts[1] << (BIT_SIZE*1)
    c = parts[2]

    a | b | c
  end

  def ==(other)
    if other.respond_to?(:to_i)
      self.to_i == other.to_i
    end
  end

  class << self
    def from_int(i)
      self.new(i)
    end

    def from_array(args)
      args = [] if args == [nil]
      args = args + DEFAULT_VALUES[args.size..-1]

      a = args[0] << (BIT_SIZE*2)
      b = args[1] << (BIT_SIZE*1)
      c = args[2]

      self.new(a | b | c)
    end
  end
end