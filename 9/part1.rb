# File.open!('input.txt')
#   |> IO.read(:line)
  "{{<a!>},{<a!>},{<a!>},{<ab>}}"
  |> String.replace(~r/!./,"")
  |> String.replace(~r/<[^>]*>/,"")
  |> String.split("")