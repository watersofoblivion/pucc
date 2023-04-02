/* Entry Point (for Testing) */
%type <ParseEnv.env -> (ParseEnv.env * Syntax.pkg)> parse_pkg
%start parse_pkg

%%

/*
 * Testing
 */

%public parse_pkg:
| pkg = pkg; EOF { pkg }

/*
 * Implementation
 */

/* Package Statements */
%public pkg:
| "library";    id = name { Actions.pkg_library    $sloc id }
| "executable"; id = name { Actions.pkg_executable $sloc id }
