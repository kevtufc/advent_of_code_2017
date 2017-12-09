defmodule Advent09 do
  def score(["{"|t]), do: 1 + score(t, 2)
  def score(["{"|t], depth), do: depth + score(t, depth + 1)
  def score(["}"|t], depth), do: score(t, depth - 1)
  def score([""], _), do: 0
  
  def garbage_count([], _), do: 0
  def garbage_count([h|t], false) when h == "<", do: garbage_count(t, true)
  def garbage_count([h|t], true) when h == ">", do: garbage_count(t, false)
  def garbage_count([_|t], true), do: 1 + garbage_count(t, true)
  def garbage_count([_|t], false), do: garbage_count(t, false)
  
  def part_one(stream) do
    String.replace(stream, ~r/!./,"")
    |> String.replace(",","")
    |> String.replace(~r/<[^>]*>/,"")
    |> String.split("")
    |> Advent09.score
  end
  
  def part_two(stream) do
    String.replace(stream, ~r/!./,"")
    |> String.split("")
    |> garbage_count(false)
  end
end

stream = File.open!('input.txt') |> IO.read(:line)

IO.puts "Part One: #{Advent09.part_one(stream)}"
IO.puts "Part Two: #{Advent09.part_two(stream)}"