with Ada.Numerics.Float_Random, Units; use Ada.Numerics.Float_Random, Units;

generic
    Module_Group : in out Module_Array;
    Fault_Grade  : in Float;
    Fault_Filter : in Float;
    with procedure Operation(Component : in out Module);
package Module.Group is
    Outputs : Float_Array (1 .. Module_Group'Length); -- group outputs

    procedure Init_Group (Value : in Float); -- initialize modules in group and group outputs
    
    procedure Run;    -- performs "Operation" on every module in group
    procedure Status; -- prints faulty status of each module (true = Faulty)
    procedure Listen; -- prints current output value in group
    
    -- binding routines "From" value/s bound to group inputs
    procedure Bind_Single (From : in Float_Access; Position : in Positive);
    procedure Bind_Array  (From : in Float_Array;  Position : in Positive);
    procedure Bind_Multi  (From : in Float_Array;  Position : in Positive);
private
    procedure Fault_Component (Component : in out Module);
    G : Generator;
end Module.Group;
