defmodule Advent02 do
  def checksum([]), do: 0
  
  def checksum([h|t]) when is_binary(h), do: checksum(h) + checksum(t)
  
  def checksum(list) when is_list(list), do: checksum(list,list)
  
  def checksum(line) when is_binary(line) do 
    String.split(line,"\t")
    |> Enum.map(fn(x) -> String.trim(x) |> String.to_integer end)
    |> checksum
  end
  
  def checksum([_|t], []), do: checksum(t,t)

  def checksum([h|t], [h2|t2]) do
    result1 = h/h2
    result2 = h2/h
    cond do
      h == h2 -> checksum([h|t],t2)
      result1 == round(result1) -> result1
      result2 == round(result2) -> result2
      true -> round(checksum([h|t],t2))
    end
  end
end

IO.puts Enum.to_list(File.stream!('input.txt')) |> Advent02.checksum