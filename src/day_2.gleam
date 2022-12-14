import gleam/io
import gleam/int
import gleam/list
import gleam/order
import gleam/result
import gleam/string
import gleam/erlang/file

pub fn score_move(move) {
  case move {
    "A" -> Ok(1)
    "B" -> Ok(2)
    "C" -> Ok(3)

    "X" -> Ok(1)
    "Y" -> Ok(2)
    "Z" -> Ok(3)
    _ -> Error("Invalid move")
  }
}

pub fn parse_round(round) {
  case string.split(round, on: " ") {
    [l, r] -> Ok(#(l, r))
    _ -> Error("Failed to parse Round")
  }
}

pub fn part_1_compare_game(first, second) {
  case first, second {
    "A", "X" -> Ok(order.Eq)
    "A", "Y" -> Ok(order.Gt)
    "A", "Z" -> Ok(order.Lt)

    "B", "X" -> Ok(order.Lt)
    "B", "Y" -> Ok(order.Eq)
    "B", "Z" -> Ok(order.Gt)

    "C", "X" -> Ok(order.Gt)
    "C", "Y" -> Ok(order.Lt)
    "C", "Z" -> Ok(order.Eq)

    _, _ -> Error("Invalid Game")
  }
}

pub fn part_1_score_round(round) {
  let #(first, second) = round
  try result = part_1_compare_game(first, second)
  let result_score = case result {
    order.Lt -> 0
    order.Eq -> 3
    order.Gt -> 6
  }
  try my_throw = score_move(second)
  Ok(result_score + my_throw)
}

pub fn part_2_compare_game(_, second) {
  case second {
    "X" -> Ok(order.Lt)
    "Y" -> Ok(order.Eq)
    "Z" -> Ok(order.Gt)
    _ -> Error("Invalid Game")
  }
}

/// X = Lose, Y = Draw, Z = Win
pub fn part_2_required_move(theirs, result) {
  case theirs, result {
    "A", order.Eq -> Ok("A")
    "A", order.Gt -> Ok("B")
    "A", order.Lt -> Ok("C")

    "B", order.Lt -> Ok("A")
    "B", order.Eq -> Ok("B")
    "B", order.Gt -> Ok("C")

    "C", order.Gt -> Ok("A")
    "C", order.Lt -> Ok("B")
    "C", order.Eq -> Ok("C")

    _, _ -> Error("Invalid Input")
  }
}

pub fn part_2_score_round(round) {
  let #(first, second) = round
  try result = part_2_compare_game(first, second)
  let result_score = case result {
    order.Lt -> 0
    order.Eq -> 3
    order.Gt -> 6
  }

  try my_throw = part_2_required_move(first, result)
  try my_throw_score = score_move(my_throw)
  Ok(result_score + my_throw_score)
}

pub fn main() {
  assert Ok(contents) = file.read("input")

  let round_strings = string.split(contents, on: "\n")
  try rounds = result.all(list.map(round_strings, parse_round))

  try part1_scores = result.all(list.map(rounds, part_1_score_round))
  let total_part1_score = list.fold(part1_scores, 0, int.add)
  io.println("Total Part1 Score: " <> int.to_string(total_part1_score))

  try part2_scores = result.all(list.map(rounds, part_2_score_round))
  let total_part2_score = list.fold(part2_scores, 0, int.add)
  io.println("Total Part2 Score: " <> int.to_string(total_part2_score))

  Ok(0)
}
