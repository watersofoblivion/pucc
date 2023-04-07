open Cmdliner

let cmd_build =
  let info = Cmd.info "build" in
  let build _ = () in
  Cmd.v info (Term.(const build $ const ()))

let cmd_test =
  let info = Cmd.info "test" in
  let test _ = () in
  Cmd.v info (Term.(const test $ const ()))

let term_help =
  let help _ = () in
  Term.(const help $ const ())

let cmd_help =
  let info = Cmd.info "help" in
  Cmd.v info term_help

let cmd =
  let info = Cmd.info "pucc-bootstrap" in
  Cmd.group ~default:term_help info [
    cmd_help;
    cmd_build;
    cmd_test;
  ]