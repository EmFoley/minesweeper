require 'matrix'

class MinesweeperBoard
  attr_reader :field, :buried
  def initialize(size, num_mines)
    @field = Matrix.build(size){'X'}.to_a
    @buried = Matrix.build(size){'.'}.to_a
    bury_mines(size, num_mines)
  end

  def bury_mines(size, num_mines)
    num_mines.times do 
      set_mine_location(size)
    end 
  end

  def set_mine_location(size)
    row = rand(0..size-1)
    col = rand(0..size-1)
    target = @buried[row][col]
    if target == "."
      @buried[row][col] = "M"
    else
      set_mine_location(size)
    end
  end

end

class MinesweeperGame
  def initialize
    puts "Enter the size of the minesweeper board!"
    @size = gets.chomp.to_i
    puts "How many mines to bury, 1 to #{@size**2}?"
    @num_mines = gets.chomp.to_i
    board = MinesweeperBoard.new(@size, @num_mines)
    @field = board.field
    @buried = board.buried
    @finished = false
    play
  end

  def play
    while @buried.flatten.include?(".") && @finished == false
      print @field
      puts "Where do you want to check? Pick a row from 1 to #{@size}!"
      row = gets.chomp.to_i-1
      puts "Pick a column from 1 to #{@size}!"
      col = gets.chomp.to_i-1
      check_if_mine(row, col)
      play
    end
  end

  def check_if_mine(row, col)
    target = @buried[row][col]
    if target == "M"
      puts "MINE EXPLOSION! GAME OVER!"
      print @buried
      @finished = true
      return
    else
      @field[row][col] = target
      puts "This one's clear!"
    end
    @field
  end

end

game = MinesweeperGame.new

