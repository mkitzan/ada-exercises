with Units, Ada.Numerics.Discrete_Random; use Units;

generic
    Cycle_Limit   : Positive;
    System_Inputs : in out Float_Array;
    Input_Range  : in Float_Values;
    with procedure Cycle;
    with procedure Status;
package Simulator is
    -- run simulation until cycle_limit is reached
    procedure Simulate;
private
    subtype Random_Range is Positive range Input_Range'First .. Input_Range'Last;
    package Random_Input is new Ada.Numerics.Discrete_Random(Random_Range);
    use Random_Input;
    G : Generator;
    
    procedure Generate_All;
end Simulator;
