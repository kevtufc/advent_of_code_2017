input = IO.read('input.txt').split("\n")

towers = balanced = []
input.each do |l| 
  t,b = l.split(' -> ')
  t = t.split(' ')[0]
  towers << t
  balanced += b&.split(', ') || []
end

puts "Part 1"
puts towers.sort.inspect
puts balanced.sort.inspect
puts (towers - balanced).inspect