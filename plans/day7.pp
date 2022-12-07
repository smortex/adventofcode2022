plan adventofcode2022::day7 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day7.txt',
    true  => 'adventofcode2022/day7.sample.txt',
  }
  $lines = file($file).split('\n')

  [$cwd, $files, $directories] = $lines.reduce([[], {}, []]) |$memo, $line| {
    [$cwd, $files, $directories] = $memo

    $new_cwd = $line ? {
      /\A\$ cd \/\z/   => [],
      /\A\$ cd \.\.\z/ => $cwd[0, -2],
      /\A\$ cd (.*)\z/ => $cwd << $1,
      default          => $cwd,
    }

    $new_files = $line ? {
      /\A(\d+) (.*)\z/ => $files + { ($cwd << $2).prefix('/').join => Integer($1) },
      default          => $files,
    }

    $new_directories = $line ? {
      /\A\$ cd ([a-z]+)\z/ => $directories << ($cwd << $1).prefix('/').join,
      default              => $directories,
    }

    [$new_cwd, $new_files, $new_directories]
  }

  $directory_sizes = Hash($directories.map |$directory| {
    $size = $files.filter |$filename, $size| {
      $filename =~ "^${directory}/"
    }.values.reduce(0) |$memo, $value| { $memo + $value }
  
    [$directory, $size]
  })
  
  $directory_sizes.values.filter |$size| {
    $size < 100000
  }.reduce |$memo, $value| {
    $memo + $value
  }.out::message

  # Part 2

  $filesystem_size = 70000000
  $needed_space = 30000000

  $used_space = $files.values.reduce |$memo, $value| {
    $memo + $value
  }
  $free_space = $filesystem_size - $used_space

  $removable_directories = $directory_sizes.filter |$directory, $size| {
    $free_space + $size >= $needed_space
  }

  $selected_directory_size = $removable_directories.values.min

  $removable_directories.filter |$directory, $size| {
    $size == $selected_directory_size
  }.values[0].out::message
}
