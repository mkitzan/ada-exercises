-- Implements the Knuth-Morris-Pratt pattern search algorithm via a DFA

package Pattern_Search_KMP is
    -- accepts all printable ascii characters
    type DFA is array (Character range <>, Positive range <>) of Positive;
    
    function Search (Text, Pattern : in String) return Positive;
private
    procedure Build_DFA (Automaton : in out DFA; Pattern : in String);
end Pattern_Search_KMP;
