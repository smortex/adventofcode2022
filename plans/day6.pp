plan adventofcode2022::day6 (
  Boolean $sample = false,
  Integer $size = 4,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day6.txt',
    true  => 'adventofcode2022/day6.sample.txt',
  }
  file($file).split('\n').map |$line| {
    $line.index |$n, $char| {
      Array($line[$n, $size]).unique.size == $size
    } + $size
  }.out::message
}
