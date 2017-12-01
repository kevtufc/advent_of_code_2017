defmodule Advent01 do

  def sum(input), do: sum(input, input)
  def sum([h,""],[h|_]), do: String.to_integer(h)
  def sum([""], _),   do: 0
  
  def sum([h|t], input) do
    [h2|_] = t
    case {h, h2} do
      {x, x} -> String.to_integer(x) + sum(t,input)
      {_, _} -> sum(t,input)
    end
  end
end

File.open!('input.txt') |> IO.read(:line) |> String.split("") |> Advent01.sum |> IO.puts