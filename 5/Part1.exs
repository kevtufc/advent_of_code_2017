defmodule Advent05 do

  def count_steps(ins), do: count_steps(ins, 0)
  def count_steps(_, x) when x < 0, do: 0
  def count_steps(ins, x) when x > (tuple_size(ins) - 1), do: 0
  
  def count_steps(ins, x) do
    step = elem(ins, x)
    1 + count_steps(put_elem(ins, x, step + 1), x + step)
  end

end
 
IO.puts File.stream!("input.txt") 
|> Stream.map(fn(x) -> String.trim_trailing(x) |> String.to_integer end) 
|> Enum.to_list
|> List.to_tuple
|> Advent05.count_steps  
