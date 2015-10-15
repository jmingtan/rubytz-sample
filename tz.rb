TIMEZONES = {
  :utc => 0,
  :sgt => 8,
  :mst => -7,
}

class TZ
  attr_reader :h, :m

  def initialize(h, m, tz = :utc)
    @h = (h + 24) % 24
    @m = (m + 60) % 60
    @tz = tz
  end

  def method_missing(name, *args)
    if TIMEZONES.has_key? name
      offset = TIMEZONES[name]
      new_h = 0
      if @tz == :utc
        new_h = @h + offset
      else
        new_h = @h - TIMEZONES[@tz] + offset
      end
      TZ.new(new_h, @m, name)
    else
      super(name, args)
    end
  end

  def to_s
    return "#{@h}:#{@m} #{@tz.to_s.upcase}"
  end
end

class String
  def method_missing(name, *args)
    if self.size >= 4 and TIMEZONES.has_key? name
      TZ.new(self[0..1].to_i, self[-2..-1].to_i, name)
    else
      super(name, args)
    end
  end
end

class Fixnum
  def method_missing(name, *args)
    if TIMEZONES.has_key? name
      self.to_s.rjust(4, '0').send(name)
    else
      super(name, args)
    end
  end
end
