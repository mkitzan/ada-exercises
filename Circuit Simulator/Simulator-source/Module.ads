with Units; use Units;

generic
    Inputs : in Positive;
package Module is
    type Module is record
        Faulty : Boolean := False;
        Input  : Float_Array(1 .. Inputs);
        Output : Float_Access;
        Repair : Integer := 0;
    end record;
    
    type Module_Array is array (Positive range <>) of Module;
    
    -- initialize a single module
    procedure Init_Module (Component  : in out Module; Value : in Float);
end Module;
