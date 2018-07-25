--
-- Package body for generic queue
--

package body Union_Find is
    -- hidden attributes
    Parent : array (1 .. Size) of Integer;
    Rank   : array (1 .. Size) of Natural;

    -- operation bodies
    procedure Union (A, B : in Integer) is
        Root_A, Root_B : Integer;
    begin
        Validate(A);
        Validate(B);
    
        Root_A := Find(A);
        Root_B := Find(B);
    
        if Root_A = Root_B then
            return;
        end if;
        
        if Rank(Root_A) < Rank(Root_B) then
            Parent(Root_A) := Root_B;
        elsif Rank(Root_A) > Rank(Root_B) then
            Parent(Root_B) := Root_A;
        else
            Parent(Root_B) := Root_A;
            Rank(Root_A)   := Rank(Root_A) + 1;
        end if;
    end Union;
    
    function Find (Key : in Integer) return Integer is
        Temp : Integer;
    begin
        Validate(Key);
    
        Temp := Key;
    
        while Temp /= Parent(Temp) 
        loop
            Parent(Temp) := Parent(Parent(Temp));
            Temp         := Parent(Temp);
        end loop;
            
        return Temp;
    end Find;
    
    procedure Reset is
    begin
        for Item in 1 .. Size
        loop
            Parent(Item) := Item;
            Rank(Item)   := 0;
        end loop;
    end Reset;
    
    procedure Validate (Key : in Integer) is
    begin
        if Key < 1 or Key > Size then
            raise Range_Exception;
        end if;
    end Validate;

-- initialization    
begin
    Reset;
end Union_Find;
        