(** {1 Command-Line Interface} *)

open Cmdliner

(** {2 Commands} *)

val cmd_build : unit Cmd.t
(**
 * Command to build packages.
 *)

val cmd_test : unit Cmd.t
(**
 * Command to test packages.
 *)

val cmd_help : unit Cmd.t
(**
 * Command to display help information
 *)

val cmd : unit Cmd.t
(**
 * The top-level command
 *)
