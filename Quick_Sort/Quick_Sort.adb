--
-- Package body for generic quick sort
--

with Stack;

package body Quick_Sort is
    procedure Sort (Unsorted : in out T_Array) is
        Split : Integer;
        Lower : Integer := Unsorted'First;
        Upper : Integer := Unsorted'Last;
        package T_Stack is new Stack(Integer, Unsorted'Length);
    begin
        T_Stack.Push(Lower);
        T_Stack.Push(Upper);
        
        while not T_Stack.Is_Empty
        loop
            Upper := T_Stack.Pop;
            Lower := T_Stack.Pop;
            Split := Partition(Unsorted => Unsorted, Lower => Lower, Upper => Upper);
        
            if Split - 1 > Lower then
                T_Stack.Push(Lower);
                T_Stack.Push(Split - 1);
            end if;
            
            if Split + 1 < Upper then
                T_Stack.Push(Split + 1);
                T_Stack.Push(Upper);
            end if;
        end loop;
    end Sort;

    procedure Swap (Item_A, Item_B : in out T) is
        Temp : constant T := Item_A;
    begin
        Item_A := Item_B;
        Item_B := Temp;
    end Swap;
    
    function Partition (Unsorted : in out T_Array; Lower, Upper : in Integer) return Integer is
        Pivot : constant T := Unsorted(Upper);
        Bound : Integer := Lower;
    begin
        for I in Lower .. Upper - 1
        loop
            if Compare(Unsorted(I), Pivot) then
                Swap(Unsorted(Bound), Unsorted(I));
                Bound := Bound + 1;
            end if;
        end loop;
        
        Swap(Unsorted(Bound), Unsorted(Upper));
        return Bound;
    end Partition;
end Quick_Sort;
