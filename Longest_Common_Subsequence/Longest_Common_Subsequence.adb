with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Longest_Common_Subsequence is
    -- hard coded data which would be procedure input
    X : constant String := "skullandbones";
    Y : constant String := "lullabybabies"; 
    -- precalculated llcs table
    type Integer_Array is array (Integer range <>, Integer range <>) of Integer;
    LLCS : constant Integer_Array(1 .. X'Last, 1 .. Y'Length) :=
        ((0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
         (0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
         (0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
         (0, 0, 1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3),
         (0, 0, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 5, 5),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 5, 5),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 5, 5),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 5, 5),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 5, 5),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 5, 5),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 6, 6),
         (0, 0, 1, 2, 3, 4, 4, 4, 5, 5, 5, 6, 7));
       -- s  k  u  l  l  a  n  d  b  o  n  e  s        
       
    -- procedure variables
    LCS : Unbounded_String := To_Unbounded_String("");
    I : Integer := LLCS'Last(1);
    J : Integer := LLCS'Last(2);
begin
    while LLCS(I, J) /= 0 and I /= 1 and J /= 1
    loop
        if LLCS(I, J) = LLCS(I, J - 1) then
            J   := J - 1;
        elsif LLCS(I, J) = LLCS(I - 1, J) then
            I   := I - 1;
        else
            LCS := X(J) & LCS;
            I   := I - 1;
            J   := J - 1;
        end if;
    end loop;

    if LLCS(I, J) /= 0 then
        LCS := X(J) & LCS;
    end if;
    
    Put_Line(To_String(LCS)); -- output lcs -> ullabes
end Longest_Common_Subsequence;
