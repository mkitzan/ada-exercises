with Ada.Numerics.Float_Random, Units; use Ada.Numerics.Float_Random, Units;

generic
    Module_Group : in out Module_Array;
    Fault_Grade  : in Float;
    Fault_Filter : in Float;
    with procedure Operation(Component : in out Module);
package Module.Group is
    procedure Run;
    procedure Status;
    procedure Listen;
    
    procedure Bind_From (To : out Float_Array);
    procedure Bind_To   (From : in Float_Array; Position : in Positive);
private
    procedure Fault_Component (Component : in out Module);
    G : Generator;
end Module.Group;
