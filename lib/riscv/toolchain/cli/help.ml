open Cmdliner

let cmd_help =
  let doc = "Hardware Playground" in
  let sdocs = Manpage.s_common_options in
  let man = [
    `S Manpage.s_description;

    `P ("$(mname) is my hardware playground")
  ] in

  let term = Term.(ret (const (fun _ -> `Help (`Pager, None)) $ const ())) in
  let info = Cmd.info "hdub" ~doc ~sdocs ~exits:Common.exits ~man in

  (term, info)
