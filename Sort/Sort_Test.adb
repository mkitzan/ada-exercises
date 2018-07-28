with Ada.Text_IO,Sort; use Ada.Text_IO;

procedure Sort_Test is
    -- Array type for QSort MUST BE indefinite range
    type Char_Array is array (Positive range <>) of Character;
    
    -- Compare function for the generic's type
    function Char_Compare (Char_1, Char_2 : in Character) return Boolean is
    begin
        return Char_1 < Char_2;
    end Char_Compare;
    
    package Sorter is new Sort(Character, Char_Array, Char_Compare);
    
    QS_Str : Char_Array := ('Q','u','i','c','k','S','o','r','t','T','e','s','t','S','t','r','i','n','g');
    IS_Str : Char_Array := ('I','n','s','e','r','t','i','o','n','S','o','r','t','T','e','s','t','S','t','r','i','n','g');
begin
    -- Quick sort test
    Put("Before sort: ");
    for Char of QS_Str
    loop
        Put(Char);
    end loop;
    New_Line;
    
    -- Usage
    Sorter.Quick(Unsorted => QS_Str);
    
    Put("After sort:  ");
    for Char of QS_Str
    loop
        Put(Char);
    end loop;
    New_Line;
    
    -- Insertion sort test
    Put("Before sort: ");
    for Char of IS_Str
    loop
        Put(Char);
    end loop;
    New_Line;
    
    -- Usage
    Sorter.Insertion(Unsorted => IS_Str);
    
    Put("After sort:  ");
    for Char of IS_Str
    loop
        Put(Char);
    end loop;
    New_Line;
end Sort_Test;