import gleeunit
import gleeunit/should
import day_2

pub fn main() {
  gleeunit.main()
}

// All 3 of these tests come from the examples given
pub fn example_part_1_test_1_test() {
  day_2.part_1_score_round(#("A", "Y"))
  |> should.equal(Ok(8))
}

pub fn example_part_1_test_2_test() {
  day_2.part_1_score_round(#("B", "X"))
  |> should.equal(Ok(1))
}

pub fn example_part_1_test_3_test() {
  day_2.part_1_score_round(#("C", "Z"))
  |> should.equal(Ok(6))
}

// All 3 of these tests come from the examples given
pub fn example_part_2_test_1_test() {
  day_2.part_2_score_round(#("A", "Y"))
  |> should.equal(Ok(4))
}

pub fn example_part_2_test_2_test() {
  day_2.part_2_score_round(#("B", "X"))
  |> should.equal(Ok(1))
}

pub fn example_part_2_test_3_test() {
  day_2.part_2_score_round(#("C", "Z"))
  |> should.equal(Ok(7))
}
