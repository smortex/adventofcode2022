plan adventofcode2022::day1 (
  Boolean $sample = false,
) {
  $file = $sample ? {
    false => 'adventofcode2022/day1.txt',
    true  => 'adventofcode2022/day1.sample.txt',
  }
  $each_elf_carry_as_string = file($file).split('\n\n')

  $each_elf_carry_as_array_of_integers = $each_elf_carry_as_string.map |$value| { $value.split('\n').map |$value| { Integer($value) } }

  $each_elf_total_carry = $each_elf_carry_as_array_of_integers.map |$carry| { $carry.reduce |$memo, $value| { $memo + $value } }

  $each_elf_total_carry.max.out::message
  $each_elf_total_carry.sort[-3, -1].reduce |$memo, $value| { $memo + $value }.out::message
}
