with Ada.Text_IO,Quick_Sort; use Ada.Text_IO;

procedure QS_Test is
    -- Array type for QSort MUST BE indefinite range
    type Char_Array is array (Positive range <>) of Character;
    
    -- Compare function for the generic's type
    function Char_Compare (Char_1, Char_2 : in Character) return Boolean is
    begin
        return Char_1 < Char_2;
    end Char_Compare;
    
    package QSort is new Quick_Sort(Character, Char_Array, Char_Compare);
    
    Test_Str : Char_Array := ('A','n','U','n','s','o','r','t','e','d','C','h','a','r','a','c','t','e','r','S','e','t');
begin
    Put("Before sort: ");
    for Char of Test_Str
    loop
        Put(Char);
    end loop;
    New_Line;
    
    -- Usage
    QSort.Sort(Unsorted => Test_Str);
    
    Put("After sort:  ");
    for Char of Test_Str
    loop
        Put(Char);
    end loop;
    New_Line;
end QS_Test;