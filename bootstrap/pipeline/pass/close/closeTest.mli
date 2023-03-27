(**
 * {1 Closure Conversion Tests}
 *
 * Functions for testing the Closure Conversion pass
 *)

(**
 * {2 Environment}
 *)

(**
 * {3 Fixtures}
 *)

val fresh_env : unit -> Close.env
(**
 * Construct a fresh environment.
 *
 * @param _ A dummy parameter
 * @return A fresh environment
 *)