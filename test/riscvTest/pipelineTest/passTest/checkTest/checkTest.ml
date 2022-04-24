open OUnit2

(*

let wide_widths = [
  RiscvAsmLangAsm.DWord;
  RiscvAsmLangAsm.Word;
]
let narrow_widths = [
  RiscvAsmLangAsm.HWord;
  RiscvAsmLangAsm.Byte;
]

let for_widths widths fn = List.iter fn widths
let for_wide_widths = for_widths wide_widths
let for_narrow_widths = for_widths narrow_widths

let assert_invalid_mneumonic_width allowed width fn =
  let exn = RiscvAsmLangAsm.InvalidMneumonicWidth { width; allowed } in
  assert_raises exn fn
let assert_wide_widths_only = assert_invalid_mneumonic_width wide_widths

*)

let suite =
  "Checking" >::: [
  ]
