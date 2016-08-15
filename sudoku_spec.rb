require 'rspec'
require_relative 'sudoku'

describe Sudoku do
  let (:board)      { "090000006000960485000581000004000000517200900602000370100804020706000810300090000" }
  let (:my_sudoku)  { Sudoku.new(board) }

  describe "#parse_board" do
    it "should parse a sudoku board into a 2D array" do
      parsed_board = my_sudoku.parse_board(board)
      expected_board =  [
                          [0,9,0,0,0,0,0,0,6], 
                          [0,0,0,9,6,0,4,8,5], 
                          [0,0,0,5,8,1,0,0,0], 
                          [0,0,4,0,0,0,0,0,0], 
                          [5,1,7,2,0,0,9,0,0], 
                          [6,0,2,0,0,0,3,7,0], 
                          [1,0,0,8,0,4,0,2,0], 
                          [7,0,6,0,0,0,8,1,0], 
                          [3,0,0,0,9,0,0,0,0]
                        ]

      expect(parsed_board.length).to eq(9)
      expect(parsed_board[0].length).to eq(9)
      expect(parsed_board).to eq(expected_board)
    end
  end

  describe "#save_empty_positions" do
    it "should save all of the empty positions, 0s, in a parsed board" do
      parsed_board = my_sudoku.parse_board(board)
      empty_positions = my_sudoku.save_empty_positions(parsed_board)
      expected_positions =  [
                              [0,0],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[1,0],[1,1], 
                              [1,2],[1,5],[2,0],[2,1],[2,2],[2,6],[2,7],[2,8],[3,0], 
                              [3,1],[3,3],[3,4],[3,5],[3,6],[3,7],[3,8],[4,4],[4,5], 
                              [4,7],[4,8],[5,1],[5,3],[5,4],[5,5],[5,8],[6,1],[6,2], 
                              [6,4],[6,6],[6,8],[7,1],[7,3],[7,4],[7,5],[7,8],[8,1], 
                              [8,2],[8,3],[8,5],[8,6],[8,7],[8,8]
                            ]
      expect(empty_positions.length).to eq(51)
      expect(empty_positions).to eq(expected_positions)
    end
  end

  describe "#check_row" do
    it "should check that each value in the row does not equal the input" do
      parsed_board = my_sudoku.parse_board(board)
      expect(my_sudoku.check_row(parsed_board, 0, 2)).to be(true)
      expect(my_sudoku.check_row(parsed_board, 0, 9)).to be(false)
    end
  end

  describe "#check_column" do
    it "should check that each value in a column does not equal the input" do
      parsed_board = my_sudoku.parse_board(board)
      expect(my_sudoku.check_column(parsed_board, 0, 9)).to be(true)
      expect(my_sudoku.check_column(parsed_board, 0, 5)).to be(false)
    end
  end

  describe "#check_3x3_square" do
    it "should check that each value in a 3x3 square does not match the input" do
      parsed_board = my_sudoku.parse_board(board)
      expect(my_sudoku.check_3x3_square(parsed_board, 2, 2, 1)).to be(true)
      expect(my_sudoku.check_3x3_square(parsed_board, 7, 7, 9)).to be(true)
      expect(my_sudoku.check_3x3_square(parsed_board, 2, 2, 9)).to be(false)
      expect(my_sudoku.check_3x3_square(parsed_board, 7, 7, 1)).to be(false)
    end
  end
end