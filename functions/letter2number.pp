function adventofcode2022::letter2number(String $n) >> Integer {
  $offset = $n ? {
    /[a-z]/ => 1,
    /[A-Z]/ => 27,
  }
  'abcdefghijklmnopqrstuvwxyz'.index |$char| { $char == $n } + $offset
}
