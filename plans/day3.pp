plan adventofcode2022::day3 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day3.txt',
    true  => 'adventofcode2022/day3.sample.txt',
  }
  $data = file($file)

  $result1 = $data.split('\n').map |$line| {
    $split_at = $line.size / 2
    $part1 = $line[0, $split_at].split('')
    $part2 = $line[$split_at, -1].split('')

    $n = intersection($part1, $part2)[0]

    $n.adventofcode2022::letter2number
  }.reduce |$memo, $value| { $memo + $value }

  out::message($result1)

  $result2 = $data.split('\n').slice(3).map |$a| {
    $n = intersection(intersection($a[0].split(''), $a[1].split('')), $a[2].split(''))[0]
    $n.adventofcode2022::letter2number
  }.reduce |$memo, $value| { $memo + $value }

  out::message($result2)
}
