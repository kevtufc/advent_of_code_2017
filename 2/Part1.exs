defmodule Advent02 do
  def checksum([]), do: 0
  
  def checksum([h|t]) when is_binary(h), do: checksum(h) + checksum(t)
  
  def checksum(list) when is_list(list), do: Enum.max(list) - Enum.min(list)
  
  # def checksum([h|t]) when is_integer(h), do: checksum(h) + checksum(t)
  
  # def checksum([h|t]) when is_string(h), do: Enum.checksum(h) + checksum(t)
  
  def checksum(line) when is_binary(line) do 
    String.split(line,"\t")
    |> Enum.map(fn(x) -> String.trim(x) |> String.to_integer end)
    |> checksum
  end

end


IO.puts Enum.to_list(File.stream!('input.txt')) |> Advent02.checksum
