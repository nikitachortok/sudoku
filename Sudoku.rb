def in_row(grid,i,k)
  grid[i].include? k
end

def in_col(grid,j,k)
  0.upto(8) do |i|
    return true if grid[i][j] == k
  end
  false
end

def in_grid(grid,i,j,k)
  x,y =0,0
  x = 3 if i > 2
  x = 6 if i > 5
  y = 3 if j > 2
  y = 6 if j > 5
  x.upto(x+2) do |xx|
    y.upto(y+2) do |yy|
      return true if grid[xx][yy] == k
    end
  end
  return false
end

def find_unassigned_location(grid)
  grid.each_with_index do |rows,i|
    rows.each_with_index do |cols,j|
      return [i,j] if cols == 0
    end
  end
  false
end
def sudoku_solve grid
  cell = find_unassigned_location(grid)
  return [true,grid] unless cell
  i,j = cell[0],cell[1]
  1.upto(9) do |k|
    next if in_row(grid,i,k) || in_col(grid,j,k) || in_grid(grid,i,j,k)
    grid[i][j] = k
    return [true,grid] if sudoku_solve(grid)[0] == true
    grid[i][j] = 0
  end
  return [false,grid]
end
def print_grid (grid)
  grid.each do |rows|
    rows.each do |cols|
      print "#{cols} "
    end
    puts ''
  end
end

board = []
(0...9).each do |i|
  board << gets.split.map {|num| num.to_i}
end
solution = sudoku_solve(board)
print_grid(solution[1]) if solution[0]