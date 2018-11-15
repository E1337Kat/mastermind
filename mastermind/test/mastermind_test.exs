defmodule MastermindTest do
  alias Mastermind.Game
  use ExUnit.Case

  test "score all wrong" do
    expected = %{
      reds: 0,
      whites: 0,
    }

    guess = [5, 6, 5, 6]
    answer = [1, 2, 3, 4]
    assert Mastermind.score(guess, answer) == expected
  end

  test "guess 1 right red" do
    expected = %{
      reds: 1,
      whites: 0,
    }

    guess =  [1, 6, 5, 6]
    answer = [1, 2, 3, 4]
    assert Mastermind.score(guess, answer) == expected
  end

  test "guess whites and reds, one each" do
    expected = %{
      reds: 1,
      whites: 1,
    }

    guess =  [2, 2, 1, 2]
    answer = [1, 2, 3, 4]
    assert Mastermind.score(guess, answer) == expected
  end

  test "guess whites, with multiples" do
    expected = %{
      reds: 0,
      whites: 1,
    }

    guess =  [1, 1, 2, 6]
    answer = [2, 2, 7, 8]
    assert Mastermind.score(guess, answer) == expected
  end

  test "game creation works" do
    # DELETE THIS then write the test to make sure Game.create works as expected
  end

  test "detect winning move" do
    winning_move =
      %{
        score: %{
          reds: 4,
          whites: 0
        },
        guess: [1, 2, 3, 4]
      }

    game =
      %{
        answer: [1, 2, 3, 4],
        moves: [winning_move],
        number_of_moves: 1
      }

    assert Game.win?(game)
  end

  test "detect nonwinning move" do
    non_winning_move =
      %{
        score: %{
          reds: 3,
          whites: 0
        },
        guess: [1, 2, 3, 6]
      }

    game =
      %{
        answer: [1, 2, 3, 4],
        moves: [non_winning_move],
        number_of_moves: 1
      }

    refute Game.win?(game)
  end

  test "make first move" do
    game =
      Game.create([1, 2, 3, 4])
      |> Game.move([1, 2, 3, 6])

    assert game.answer == [1, 2, 3, 4]
    assert game.number_of_moves == 1
    [move] = game.moves
    assert move.score.reds == 3
  end
end
