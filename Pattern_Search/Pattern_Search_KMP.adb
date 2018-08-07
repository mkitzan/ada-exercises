
package body Pattern_Search_KMP is
    function Search (Text, Pattern : in String) return Positive is
        -- first dimension is range of the set of all printable ascii characters
        Automaton : DFA(' ' .. '~', 1 .. Pattern'Length);
        N : Positive := Text'Length;
        M : Positive := Pattern'Length;
        I, J : Positive := 1;
    begin
        Build_DFA(Automaton, Pattern);
        
        while I < N and J < M
        loop
            J := Automaton(Text(I), J);
            I := I + 1;
        end loop;
        
        if J = M then
            return I-M;
        else
            return N;
        end if;
    end Search;

    procedure Build_DFA (Automaton : in out DFA; Pattern : in String) is
        X : Positive := 1;
    begin
        -- build DFA in O(R*M) time R = size of alphabet, M = length of pattern
        for C in Automaton'range(1)
        loop
            Automaton(C, X) := 1;
        end loop;
        Automaton(Pattern(Pattern'First), X) := 2;
    
        for I in 2 .. Pattern'Length
        loop
            for C in Automaton'range(1)
            loop
                Automaton(C, I) := Automaton(C, X);
            end loop;
            Automaton(Pattern(I), I) := I+1;
            
            X := Automaton(Pattern(I), X);
        end loop;
    end Build_DFA;
end Pattern_Search_KMP;
