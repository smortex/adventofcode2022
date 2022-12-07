plan adventofcode2022::day2 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day2.txt',
    true  => 'adventofcode2022/day2.sample.txt',
  }
  $data = file($file)

  $rounds = $data.split('\n').map |$line| { [$line[0], $line[2]] }

  $scores1 = $rounds.map |$round| {
    $shape_score = $round[1] ? {
      'X' => 1,
      'Y' => 2,
      'Z' => 3,
    }
    $outcome_score = $round ? {
      ['A', 'X'] => 3,
      ['A', 'Y'] => 6,
      ['A', 'Z'] => 0,
      ['B', 'X'] => 0,
      ['B', 'Y'] => 3,
      ['B', 'Z'] => 6,
      ['C', 'X'] => 6,
      ['C', 'Y'] => 0,
      ['C', 'Z'] => 3,
    }

    $shape_score + $outcome_score
  }

  $scores2 = $rounds.map |$round| {
    $outcome_score = $round[1] ? {
      'X' => 0,
      'Y' => 3,
      'Z' => 6,
    }

    $shape_score = $round ? {
      ['A', 'X'] => 3,
      ['A', 'Y'] => 1,
      ['A', 'Z'] => 2,
      ['B', 'X'] => 1,
      ['B', 'Y'] => 2,
      ['B', 'Z'] => 3,
      ['C', 'X'] => 2,
      ['C', 'Y'] => 3,
      ['C', 'Z'] => 1,
    }

    $shape_score + $outcome_score
  }

  $scores1.reduce |$memo, $score| { $memo + $score }.out::message
  $scores2.reduce |$memo, $score| { $memo + $score }.out::message
}
