
package body Units is
    procedure Init_Array (Access_Array : in out Float_Array) is
    begin    
    for Access_Value of Access_Array
        loop
            Access_Value := new Float;
        end loop;
    end Init_Array;
    
    procedure Bind (From : in Float_Array; To : out Float_Array) is
    begin
        for I in 1 .. To'Length
        loop
            To(I) := From(I);
        end loop;
    end Bind;
end Units;
