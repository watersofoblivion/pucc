open Cmdliner

let cmd_help =
  let doc = "RISC-V" in
  let sdocs = Manpage.s_common_options in
  let man = [
    `S Manpage.s_description;

    `P ("$(mname) is an implementation of the RISC-V (RV64I) ISA")
  ] in

  let term = Term.(ret (const (fun _ -> `Help (`Pager, None)) $ const ())) in
  let info = Cmd.info "riscv" ~doc ~sdocs ~exits:Common.exits ~man in

  (term, info)
