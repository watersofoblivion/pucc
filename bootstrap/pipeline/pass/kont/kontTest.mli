(**
 * {1 CPS Conversion Tests}
 *
 * Functions for testing the CPS Conversion pass
 *)

(**
 * {2 Environment}
 *)

(**
 * {3 Fixtures}
 *)

val fresh_env : unit -> Kont.env
(**
 * Construct a fresh environment.
 *
 * @param _ A dummy parameter
 * @return A fresh environment
 *)