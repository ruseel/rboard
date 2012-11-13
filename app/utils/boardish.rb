def max(bit_size)
  2 ** bit_size - 1
end

#
# Immutable pattern
#  Bit 사이즈를 3으로 해야 하나?
#
class Boardish
  attr_accessor :parts

  BIT_SIZE = 3
  DEPTH_SPEC = [23, BIT_SIZE, BIT_SIZE]
  DEFAULT_VALUES = [0, max(BIT_SIZE), max(BIT_SIZE)]

  def initialize(*args)
    args = [] if args == [nil]
    @parts = args + DEFAULT_VALUES[args.size..-1]
  end

  def inc_at_depth(depth)
    self.class.new(*parts).tap do |n|
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
      a = i >> (BIT_SIZE*2)
      b = (i & 0b111111) >> BIT_SIZE
      c = (i & 0b111)

      self.new(a, b, c)
    end

    def from_array(list)
      self.new(*list)
    end
  end
end