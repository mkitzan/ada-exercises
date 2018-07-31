with Units; use Units;

generic
    Inputs : in Positive;
package Module is
    type Module is record
        Faulty : Boolean := False;
        Input  : Float_Array(1 .. Inputs);
        Output : Float_Access;
    end record;
    
    type Module_Array is array (Positive range <>) of Module;
    
    procedure Init_Module (Component  : in out Module);
    procedure Init_Array  (Components : in out Module_Array);
end Module;
