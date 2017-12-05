defmodule Advent04 do
  def count_valid([]), do: 0
    
  def count_valid([h|t]) do 
    count_valid(t) + if invalid?(h), do: 0, else: 1 
  end
    
  def invalid?([_]), do: false
  
  def invalid?([h|t]), do: Enum.member?(t, h) || invalid?(t)

  def invalid?(line) do
    invalid?(String.split(line) |> sort_words)
  end
  
  def sort_words(list) do
    Enum.map(list, fn(x) -> String.split(x,"") |> Enum.sort |> Enum.join end)
  end
end

IO.puts Enum.to_list(File.stream!('input.txt')) |> Advent04.count_valid