(** {1 Command-Line Interface} *)

open Cmdliner

(** {2 Commands} *)

val cmds : (unit Term.t * Cmd.info) list
(** [cmds] is all of the available commands. *)

val cmd_default : unit Term.t * Cmd.info
(** [cmd_default] is the default command, run if no specific command is given.  This
    is an alias for the [help] command. *)

val cmd_help : unit Term.t * Cmd.info
(** [cmd_help] displays help information. *)
