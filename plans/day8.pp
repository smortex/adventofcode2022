plan adventofcode2022::day8 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day8.txt',
    true  => 'adventofcode2022/day8.sample.txt',
  }
  $data_lines = file($file).split('\n')

  $field = $data_lines.map |$line| { $line.map |$height| { Integer($height) } }

  $lines   = $data_lines.size
  $columns = $data_lines[0].size

  Array($lines).map |$l| {
    Array($columns).map |$c| {
      $line = $field[$l]
      $column = $field.map |$line| {
        $line[$c]
      }

      $height = $field[$l][$c]

      if [
        $line[0, $c].all |$value| { $value < $height },
        $line[$c + 1, -1].all |$value| { $value < $height },
        $column[0, $l].all |$value| { $value < $height },
        $column[$l + 1, -1].all |$value| { $value < $height },
      ].any |$value| { $value }
      {
        1
      } else {
        0
      }
    }.reduce |$memo, $value| { $memo + $value }
  }.reduce |$memo, $value| { $memo + $value }.out::message

  Array($lines).map |$l| {
    Array($columns).map |$c| {
      $line = $field[$l]
      $column = $field.map |$line| {
        $line[$c]
      }

      $height = $field[$l][$c]

      $ssl = $line[0, $c].reverse_each.reduce([0, true]) |$memo, $v| {
        [$n, $continue] = $memo

        if $continue {
          [$n + 1, $v < $height]
        } else {
          [$n, false]
        }
      }[0]
      $ssr = $line[$c + 1, -1].reduce([0, true]) |$memo, $v| {
        [$n, $continue] = $memo
        if $continue {
          [$n + 1, $v < $height]
        } else {
          [$n, false]
        }
      }[0]
      $sst = $column[0, $l].reverse_each.reduce([0, true]) |$memo, $v| {
        [$n, $continue] = $memo

        if $continue {
          [$n + 1, $v < $height]
        } else {
          [$n, false]
        }
      }[0]
      $ssb = $column[$l + 1, -1].reduce([0, true]) |$memo, $v| {
        [$n, $continue] = $memo
        if $continue {
          [$n + 1, $v < $height]
        } else {
          [$n, false]
        }
      }[0]

      $ssl * $ssr * $sst * $ssb
    }.max
  }.max.out::message
}
