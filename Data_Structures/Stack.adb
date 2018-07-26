--
-- Package body for generic stack
--

package body Stack is
    -- hidden attributes
    type Generic_Array is array (Positive range 1 .. Length) of T;
    Buffer : Generic_Array;
    Top    : Integer := 1;

    -- operation bodies
    procedure Push (Item : in T) is
    begin
        if Top > Length then
            raise Overflow_Exception;
        end if;
        
        Buffer(Top) := Item;
        Top := Top + 1;
    end Push;
    
    function Pop return T is
        Temp : T;
    begin
        if Top = 1 then
            raise Underflow_Exception;
        end if;
        
        Top := Top - 1;
        Temp := Buffer(Top);
        return Temp;
    end Pop;
    
    function Is_Empty return Boolean is
    begin
        return Top = 1;
    end Is_Empty;
    
    procedure Reset is
    begin
        Top := 1;
    end Reset;  
    
-- initialization 
begin
    Reset;
end Stack;
