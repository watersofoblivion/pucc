%{
  let symbolize id env =
    ParseEnv.symbolize env id
%}

%%

/* Literals */

%public ident:
| id = LIT_IDENT { symbolize id }
