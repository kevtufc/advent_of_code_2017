defmodule Advent01 do

  def sum(input), do: sum(input, rotate(input))
  def sum(input, x) when is_integer(x), do: sum(input, rotate(input, x))
  
  def sum([h|t], [h2|t2]) do
    case {h, h2} do
      {x, x} -> String.to_integer(x) + sum(t,t2)
      {_, _} -> sum(t,t2)
    end
  end
  
  def sum([], _), do: 0

  def rotate(list,n) do
    Enum.split(list,n) |> Tuple.to_list |> Enum.reverse |> Enum.concat
  end
  
  def rotate(list), do: rotate(list, (Enum.count(list)/2) |> round)

end

input = File.open!('input.txt') |> IO.read(:line) |> String.split("") |>  Enum.drop(-1)

IO.puts "Part One: #{Advent01.sum(input, 1)}"
IO.puts "Part Two: #{Advent01.sum(input)}"
