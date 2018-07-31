with Units; use Units;

generic
    Cycle_Limit   : Positive;
    System_Inputs : in out Float_Array;
    with function  Input_Generator return Float;
    with procedure Cycle;
    with procedure Status;
package Simulator is
    procedure Run_Simulator;
private
    procedure Generate_All;
end Simulator;
