plan adventofcode2022::day4 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day4.txt',
    true  => 'adventofcode2022/day4.sample.txt',
  }
  $data = file($file).split('\n').map |$line| {
    $line.split(',').map |$part| {
      $part.split('-').map |$n| { Integer($n) }
    }
  }

  $data.filter |$line| {
    $line[0][0] >= $line[1][0] and $line[0][1] <= $line[1][1] or
    $line[1][0] >= $line[0][0] and $line[1][1] <= $line[0][1]
  }.count.out::message

  $data.filter |$line| {
    $max_start = [$line[0][0], $line[1][0]].max
    $min_end   = [$line[0][1], $line[1][1]].min
    $min_end >= $max_start
  }.count.out::message
}
