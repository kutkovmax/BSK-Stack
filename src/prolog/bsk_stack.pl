% Represent stack as list of pairs Color-Value, head = top.
% bsk_push(Value, Stack0, Stack1).
bsk_push(V, S0, ['W'-V | S0]).

% zones: compute W and B counts
zones(S, W, B) :-
    length(S, N),
    W is floor(N * 0.3),
    B is floor(N * 0.7).

% update_colors(Stack0, Stack1)
update_colors(S0, S1) :-
    zones(S0, W, B),
    update_colors_(S0, 0, W, B, S1).

update_colors_([], _, _, _, []).
update_colors_([_-V|T], I, W, B, ['W'-V|R]) :- I < W, I1 is I+1, update_colors_(T, I1, W, B, R).
update_colors_([_-V|T], I, W, B, ['B'-V|R]) :- I >= W, I < B, I1 is I+1, update_colors_(T, I1, W, B, R).
update_colors_([_-V|T], I, W, B, ['R'-V|R2]) :- I >= B, I1 is I+1, update_colors_(T, I1, W, B, R2).

% pop: try white then blue; fail if red-locked
bsk_pop(S0, V, S1) :-
    zones(S0, W, B),
    pop_try(S0, W, B, V, S1).

pop_try([C-V|T], W, B, V, T) :- % index 0
    (C = 'W'; C = 'B'), !.
pop_try([H|T0], W, B, V, [H|T1]) :-
    pop_try(T0, W, B, V, T1).
% if reached end without finding -> throw red-locked
