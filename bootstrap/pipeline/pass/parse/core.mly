%{
  let make_loc (start_pos, end_pos) =
    let start = Core.lexing_position start_pos in
    let stop = Core.lexing_position end_pos in
    Core.loc start stop    
%}

%%
