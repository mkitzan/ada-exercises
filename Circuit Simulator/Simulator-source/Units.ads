
package Units is
    type Float_Access is access Float;
    type Float_Array  is array (Positive range <>) of Float_Access;
    
    procedure Init_Array (Access_Array : in out Float_Array);
    procedure Bind (From : in Float_Array; To : out Float_Array);
end Units;
