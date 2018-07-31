
package Units is
    -- circuit base values/structures
    type Float_Access is access Float;
    type Float_Array  is array (Positive range <>) of Float_Access;
    type Float_Values is array (Positive range <>) of Float;
    
    -- basic operations on base values/structures
    procedure Init_Array (Access_Array : in out Float_Array);
    procedure Bind (From : in Float_Array; To : out Float_Array);
end Units;
