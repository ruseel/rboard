def max(bit_size)
  2 ** bit_size - 1
end

# Immutable pattern
class Boardish
  attr_accessor :parts

  DEPTH_SPEC = [16, 7, 7, 7]
  DEFAULT_VALUES = [0, max(7), max(7), max(7)]

  def initialize(*args)
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
    a = parts[0] << (7*3)
    b = parts[1] << (7*2)
    c = parts[2] << (7*1)
    d = parts[3] << (7*0)

    a | b | c | d
  end

  def ==(other)
    if other.respond_to?(:to_i)
      self.to_i == other.to_i
    end
  end

end