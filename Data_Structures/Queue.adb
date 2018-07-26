--
-- Package body for generic queue
--

package body Queue is
    -- hidden attributes
    type Generic_Array is array (Positive range 1 .. Length) of T;
    Buffer : Generic_Array;
    Next_In, Next_Out : Integer;

    -- operation bodies
    procedure Enqueue (Value : in T) is
    begin
        if ((Next_In mod Length) + 1) = Next_Out then
            raise Overflow_Exception;
        end if;
        
        Buffer(Next_In) := Value;
        Next_In := (Next_In mod Length) + 1;
    end Enqueue;
    
    function Dequeue return T is
        Temp : T;
    begin
        if Next_Out = Next_In then
            raise Underflow_Exception;
        end if;
        
        Temp := Buffer(Next_Out);
        Next_Out := (Next_Out mod Length) + 1;
        return Temp;
    end Dequeue;
    
    function Is_Empty return Boolean is
    begin
        return Next_Out = Next_In;
    end Is_Empty;
    
    procedure Reset is
    begin
        Next_In  := 1;
        Next_Out := 1;
    end Reset;

-- initialization 
begin
    Reset;
end Queue;
