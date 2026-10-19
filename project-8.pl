% State format in queue: [F, G, [Node|Path]]
astar(Start, Goal, Path) :-
    heuristic(Start, H),
    search_astar([[H, 0, [Start]]], Goal, RevPath),
    reverse(RevPath, Path).

search_astar([[_, _, [Goal|Path]] | _], Goal, [Goal|Path]).
search_astar([[_, G, [Node|Path]] | Queue], Goal, FinalPath) :-
    findall([F_next, G_next, [Next, Node | Path]],
            (edge(Node, Next, StepCost),
             \+ member(Next, [Node|Path]),
             G_next is G + StepCost,
             heuristic(Next, H_next),
             F_next is G_next + H_next),
            NewPaths),
    append(Queue, NewPaths, Unsorted),
    keysort(Unsorted, Sorted),
    search_astar(Sorted, Goal, FinalPath).