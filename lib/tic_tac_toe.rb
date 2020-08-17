WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

board = [" "," "," "," "," "," "," "," "," "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  index=input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
    display_board(board)
end

def turn_count(board)
    counter = 0
    board.each do |move|
      if "#{move}" == "X" || "#{move}" == "O"
        counter += 1
      end
    end
    counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
    else return "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.detect do |win_combination|
      board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && position_taken?(board, win_combination[0])
    end
  end

def full?(board)
  board.all? { |a| a == "X" || a == "O" }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else won?(board) && full?(board) || won?(board) && !full?(board)
    return false
    end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
    end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else won?(board)
    winner(board) == "X" || winner(board) == "O"
      puts "Congratulations " "#{winner(board)}!"
  end
end
