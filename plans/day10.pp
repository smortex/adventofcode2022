plan adventofcode2022::day10 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day10.txt',
    true  => 'adventofcode2022/day10.sample.txt',
  }

  $instructions = file($file).split('\n')

  $trace = $instructions.reduce([[[0, -1]], 1]) |$memo, $instruction| {
    [$history, $x] = $memo
    [$cpu_cycle, $_x] = $history[-1]

    case $instruction {
      /\Aaddx (-?\d+)\z/: {
        $new_x = $x + Integer($1)
        [$history << [$cpu_cycle + 1, $x] << [$cpu_cycle + 2, $x], $new_x]
      }
      'noop': {
        [$history << [$cpu_cycle + 1, $x], $x]
      }
    }
  }[0][1, -1]

  $trace.filter |$item| {
    [$cycle, $value] = $item
    $cycle in [20, 60, 100, 140, 180, 220]
  }.reduce(0) |$memo, $status| {
    [$cycle, $value] = $status

    $cycle * $value + $memo
  }.out::message

  $trace.map |$position, $item| {
    [$cycle, $value] = $item

    if (($position % 40) - $value).abs < 2 {
      '█'
    } else {
      ' '
    }
  }.slice(40).map |$line| { $line.join }.out::message
}
