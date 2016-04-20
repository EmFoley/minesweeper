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
  attr_reader :board
  def initialize(size, num_mines)
    @board = MinesweeperBoard.new(size, num_mines)
    @field = board.field
    @buried = board.buried
    @loser = false
  end

  def solved?
    !checkable_spots? && @loser == false
  end

  def loser?
    @loser == true
  end

  def checkable_spots?
    @buried.flatten.include?(".")
  end

  def check_if_mine(row, col)
    target = @buried[row][col]
    if target == "M"
      @loser = true
    else
      @field[row][col] = target
      @buried[row][col] = " "
    end
    @field
  end

end

class MinesweeperUserInput
  def run
    start
    play
  end

  def start
    puts "Enter the size of the minesweeper board!"
    @size = gets.chomp.to_i
    puts "How many mines to bury, 1 to #{@size**2}?"
    @num_mines = gets.chomp.to_i
    @game = MinesweeperGame.new(@size, @num_mines)
  end

  def play
    print @game.board.field
    puts "Where do you want to check? Pick a row from 1 to #{@size}!"
    row = gets.chomp.to_i-1
    puts "Pick a column from 1 to #{@size}!"
    col = gets.chomp.to_i-1
    @game.check_if_mine(row, col)
    if @game.solved?
      puts "YOU WIN!"
      print @game.board.buried
    elsif @game.loser?
      puts "GAME OVER!"
      print @game.board.buried
    else
      puts "That one was clear!"
      play
    end
  end
end

if __FILE__ == $0
  MinesweeperUserInput.new.run
end

