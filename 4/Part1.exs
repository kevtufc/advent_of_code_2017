defmodule Advent04 do
  def count_valid([]), do: 0
  def count_valid([h|t]), do: (if (invalid? h), do: 0, else: 1) + count_valid(t)
    
  def invalid?([_]), do: false
  
  def invalid?([h|t]), do: Enum.member?(t, h) || invalid?(t)

  def invalid?(line), do: invalid?(String.split(line))
end

IO.puts Enum.to_list(File.stream!('input.txt')) |> Advent04.count_valid