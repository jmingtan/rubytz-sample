class TZ
  def initialize(h, m, tz)
    @h = (h + 24) % 24
    @m = (m + 60) % 60
    @tz = tz
  end

  def to_s
    return "#{@h}:#{@m} #{@tz}"
  end
end

class SGT < TZ
  def initialize(h, m)
    super(h, m, 'SGT')
  end

  def utc
    UTC.new(@h - 8, @m)
  end
end

class UTC < TZ
  def initialize(h, m)
    super(h, m, 'UTC')
  end

  def sgt
    SGT.new(@h + 8, @m)
  end
end

class String
  def utc
    UTC.new(self[0..1].to_i, self[-2..-1].to_i)
  end
end
