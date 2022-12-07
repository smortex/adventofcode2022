plan adventofcode2022::day5 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day5.txt',
    true  => 'adventofcode2022/day5.sample.txt',
  }
  $lines = file($file).split('\n')

  $separator = $lines.index |$value| { $value.empty }

  $start_position = $lines[0, $separator - 1]
  $movements      = $lines[$separator + 1, -1]

  $stack_count = ($start_position[0].length + 1) / 4

  # FIXME: We surely can create an Array of $stack_count Arrays more easily
  $empty_stacks = Array($stack_count).map |$_value| { [] }

  $stacks = $start_position.reduce($empty_stacks) |$memo, $value| {
    $memo.map |$index, $old_value| {
      $crate = $value[$index * 4 + 1]
      if $crate == ' ' {
        $old_value
      } else {
        $old_value << $value[$index * 4 + 1]
      }
    }
  }

  $movements.reduce($stacks) |$memo, $movement| {
    $x = $movement =~ /\Amove (\d+) from (\d+) to (\d+)\z/
  
    $n = Integer($1)
    $from = Integer($2) - 1
    $to = Integer($3) - 1
  
    Array($n).reduce($memo) |$memo2, $_n| {
      $crate = $memo2[$from][0]
      $memo2.map |$index, $stack| {
        if $index == $from {
          $stack[1, -1]
        } elsif $index == $to {
          [$crate] + $stack
        } else {
          $stack
        }
      }
    }
  }.map |$stack| {
    $stack[0]
  }.join.out::message

  $movements.reduce($stacks) |$memo, $movement| {
    $x = $movement =~ /\Amove (\d+) from (\d+) to (\d+)\z/

    $n = Integer($1)
    $from = Integer($2) - 1
    $to = Integer($3) - 1

    $crates = $memo[$from][0, $n]
    $memo.map |$index, $stack| {
      if $index == $from {
        $stack[$n, -1]
      } elsif $index == $to {
        $crates + $stack
      } else {
        $stack
      }
    }
  }.map |$stack| {
    $stack[0]
  }.join.out::message
}
