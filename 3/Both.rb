class Walker
  def initialize(n = 0)
    @x = 0
    @y = 0
    @used = { 0 => { 0 => 1 } }
    @dir = :r
    @n = n
    (n - 1).times { walk }
    nil
  end
  
  def rotate
    @dir = case @dir
      when :r then :u
      when :u then :l
      when :l then :d
      when :d then :r
    end
  end
  
  def walk_coords
    case @dir
      when :r then [@x+1,@y]
      when :u then [@x,@y+1]
      when :l then [@x-1,@y]
      when :d then [@x,@y-1]
    end
  end
  
  def can_walk?
    @x, @y = walk_coords
    !(@used[@x] && @used[@x][@y])
  end
  
  def can_rotate?
    t = dup
    t.rotate
    t.can_walk?
  end
  
  def walk
    rotate if can_rotate?
    @x, @y = walk_coords
    @used[@x] = {} unless @used[@x]
    if @p2_ans
      @used[@x][@y] = true
    else
      tot = total_around
      @p2_ans = tot if tot > @n
      @used[@x][@y] = tot
    end
  end
  
  def taxicab
    @x.abs + @y.abs
  end
  
  def part_two
    @p2_ans
  end
  
  def no_at(x = @x,y = @y)
    (@used[x] && @used[x][y]) || 0
  end
  
  def total_around
    [[@x-1,@y],[@x-1,@y-1],[@x-1,@y+1],
     [@x,@y+1],[@x,@y-1],
     [@x+1,@y-1],[@x+1,@y],[@x+1,@y+1]
    ].sum{|c| no_at(c[0],c[1])}
  end
end

walker = Walker.new(289326)
puts "Part One: #{walker.taxicab}"
puts "Part Two: #{walker.part_two}"
