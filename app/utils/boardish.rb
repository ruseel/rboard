def max(bit_size)
  2 ** bit_size - 1
end

# Immutable pattern
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

  def max_depth
    @parts.size
  end

  def to_i
    a = parts[0] << (BIT_SIZE*2)
    b = parts[1] << (BIT_SIZE*1)
    c = parts[2] << (BIT_SIZE*0)

    a | b | c
  end

  def ==(other)
    if other.respond_to?(:to_i)
      self.to_i == other.to_i
    end
  end

end