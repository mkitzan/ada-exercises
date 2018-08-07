with Ada.Text_IO, Pattern_Search; use Ada.Text_IO, Pattern_Search;

procedure DFA_Test is
    Text : String := "this is a test string";
    Pattern : String := "test";
    N : Positive;
begin
    N := Search(Text => Text, Pattern => Pattern);

    Put_Line(Text);
    
    for I in 1 .. N
    loop
        Put(' ');
    end loop;
    
    Put_Line(Pattern);
end DFA_Test;
