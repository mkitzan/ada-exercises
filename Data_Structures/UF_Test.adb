with Ada.Text_Io; use Ada.Text_Io;
with Union_Find;

procedure UF_Test is
    Size : Integer := 10;
    package UF is new Union_Find(Size);
begin
    -- unions every value to the first
    for I in 1 .. Size-1
    loop
        UF.Union(I, I + 1);
    end loop;
    
    for I in 1 .. Size
    loop
        Put(UF.Find(I)'Image & " ");
    end loop;
    
    New_Line;
end UF_Test;
