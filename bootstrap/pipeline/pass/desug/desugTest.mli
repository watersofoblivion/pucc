(**
 * {1 Desugaring Tests}
 *
 * Functions for testing the desugaring pass
 *)

(**
 * {2 Environment}
 *)

(**
 * {3 Fixtures}
 *)

val fresh_env : unit -> Desug.env
(**
 * Construct a fresh environment.
 *
 * @param _ A dummy parameter
 * @return A fresh environment
 *)