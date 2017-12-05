ins = IO.read('input.txt').split.map { |l| l.chomp.to_i}
x = count = 0

until x < 0 || x >= ins.size do
  count += 1
  step = ins[x]
  ins[x] = step >= 3 ? step - 1 : step + 1
  x = x + step
end

puts count