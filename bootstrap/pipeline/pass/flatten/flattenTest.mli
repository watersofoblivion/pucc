(**
 * {1 Flattening Tests}
 *
 * Functions for testing the flattening pass
 *)

(**
 * {2 Environment}
 *)

(**
 * {3 Fixtures}
 *)

val fresh_env : unit -> Flatten.env
(**
 * Construct a fresh environment.
 *
 * @param _ A dummy parameter
 * @return A fresh environment
 *)