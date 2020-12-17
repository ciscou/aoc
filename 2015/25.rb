code = 20151125

dia = 0

loop do
  dia += 1

  row, col = dia, 1

  while col <= dia
    p [row, col, code] if row == 2947 && col == 3029

    raise if row == 2947 && col == 3029

    code *= 252533
    code %= 33554393

    row -= 1
    col += 1
  end
end
