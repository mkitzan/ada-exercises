with Units; use Units;

package body Simulator is
    procedure Run_Simulator is
    begin
        for I in 1 .. Cycle_Limit
        loop
            Generate_All;
            Cycle;
            Status;
        end loop;
    end Run_Simulator;
    
    procedure Generate_All is
    begin
        for Input of System_Inputs
        loop
            Reset(G);
            Input.all := Input_Range(Random(G));
        end loop;
    end Generate_All;
end Simulator;
