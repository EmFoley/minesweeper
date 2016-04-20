require './minesweeper'
module MinesweeperSolver
  module_function
  def run
    results = []
    10.times do |num|
      puts "solving game #{num}"
      results << play_single_game
    end
    print results.select { |r| r }.length
  end

  def play_single_game
    game = MinesweeperGame.new(10,1) 
    while !game.solved? && !game.loser? do
      row = rand(0..9)
      col = rand(0..9)
      game.check_if_mine(row,col)
      if game.loser?
        puts "#{row}, #{col}"
        puts "#{game.board.buried}"
      end
    end
    game.solved?
  end
end

MinesweeperSolver.run