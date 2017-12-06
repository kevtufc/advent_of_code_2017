class Memory
  attr_accessor :banks, :states, :dups, :part_one
  def initialize
    input = "4 1 15 12 0 9 9 5 5 8 7 3 14 5 12 3"
    # input = "0 2 7 0"
    @banks = Hash[input.split("\s").map.with_index { |bank, index| [index, bank.to_i] }]
    @states = []
    @no_banks = banks.size
    @dups = []
    @part_one = nil
  end
  
  def redist
    @states << @banks.dup
    sorted = @banks.sort_by{ |k, v| [v, -k] }.map(&:first)
    index = sorted.last
    to_dist = banks[index]
    banks[index] = 0
    0.upto(to_dist - 1) do |x|
      i = (x + index + 1) % @no_banks
      @banks[i] += 1
    end
  end
  
  def double_dup?
    if @states[0..-2].include?(@states.last)
      @part_one ||= @states.count - 1
      @dups << @states.last.dup
    end
    @dups[0..-2].include?(@dups.last)
  end
end

x = Memory.new
x.redist until x.double_dup?

puts "Part One: #{x.part_one}"
puts "Part Two: #{x.states.count - 1 - x.part_one}"
