with Ada.Text_IO; use Ada.Text_IO;
with Pattern_Search_KMP, Pattern_Search_BM;


procedure DFA_Test is
    Text : String := "this is a test string";
    Pattern : String := "test";
    N : Positive;
begin
    Put_Line(Text);

    N := Pattern_Search_KMP.Search(Text => Text, Pattern => Pattern);
    for I in 1 .. N
    loop
        Put(' ');
    end loop;
    Put_Line(Pattern);
    
    N := Pattern_Search_BM.Search(Text => Text, Pattern => Pattern);
    for I in 1 .. N
    loop
        Put(' ');
    end loop;
    Put_Line(Pattern);
end DFA_Test;
