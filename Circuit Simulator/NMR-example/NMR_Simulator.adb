--
-- Circuit simulator usage example
--      N Modular Redundancy system
--      Maps N process onto M voters
-- Note: all the simulator source files must in the
--       same directory as this file to compile..
--


with Ada.Text_IO, Ada.Numerics.Discrete_Random; use Ada.Text_IO;
-- simulator with/use calls (this exact line must be present for to use the simulator)
with Units, Simulator, Module, Module.Group; use Units;

procedure NMR_Simulator is
    Clock        : Positive := 10; -- time steps to simulate
    Proc_Inputs  : Positive := 1; -- incoming connections to processors
    Voter_Inputs : Positive := 5; -- incoming connections to voters (== number of processors)
    Voter_Count  : Positive := 3; -- number of voters in system (every proc connects to every voter)
    Fault_Filter_Proc   : Float := 0.50; -- filter value over faulty processor output
    Fault_Filter_Voter  : Float := 0.50; -- filter value over faulty voter output
    Fault_Grade_Proc  : Float := 0.05; -- probability of processor failure each cycle
    Fault_Grade_Voter : Float := 0.03; -- probability of voter failure each cycle

    -- base module packages
    package Processor is new Module(Inputs => Proc_Inputs);
    package Voter    is new Module(Inputs => Voter_Inputs);
    Proc_Array  : Processor.Module_Array(1 .. Voter_Inputs);
    Voter_Array : Voter.Module_Array(1 .. Voter_Count);
    -- system inputs
    Inputs : Float_Array(1 .. Voter_Inputs);
    
    -- processor operation
    procedure Process (Component : in out Processor.Module) is
    begin
        Component.Output.all := Component.Input(1).all;
    end Process;
    -- voter operation
    procedure Vote (Component : in out Voter.Module) is
        Total : Float := 0.00;
        Diff  : Float;
    begin
        for Value of Component.Input
        loop
            Total := Total + Value.all;
        end loop;
        
        -- mid value selection
        Total := Total / Float(Component.Input'Length);
        Diff := abs (Total - Component.Input(1).all);
        Component.Output.all := Component.Input(1).all;
        
        for I in 2 .. Component.Input'Last
        loop
            if Diff > abs (Total - Component.Input(I).all) then
                Diff := abs (Total - Component.Input(I).all);
                Component.Output.all := Component.Input(I).all;
            end if;
        end loop;
    end Vote;
    
    -- create module groups
    package Proc_Group is new Processor.Group
        (Module_Group => Proc_Array, 
         Fault_Grade  => Fault_Grade_Proc, 
         Fault_Filter => Fault_Filter_Proc, 
         Operation    => Process);
    package Voter_Group is new Voter.Group
        (Module_Group => Voter_Array, 
         Fault_Grade  => Fault_Grade_Voter, 
         Fault_Filter => Fault_Filter_Voter, 
         Operation    => Vote);
    
    -- system input generator objects
    subtype Seed_Range is Integer range 1 .. 5;
    package Random_Seed is new Ada.Numerics.Discrete_Random(Seed_Range);
    use Random_Seed;
    G : Generator;
    
    -- system input generator function
    function Generate return Float is
        Seed_Values : array (1 .. 5) of Float := (0.8, 0.85, 0.9, 0.95, 1.0);
    begin
        Reset(G);
        return Seed_Values(Random(G));
    end Generate;
    
    -- a single cycle of the system
    procedure Cycle is
    begin
        -- simulator automatically generates new vlaues for system inputs
        Proc_Group.Run;  -- process new input
        Voter_Group.Run; -- votes on processor output
    end Cycle;
    -- system status survey
    procedure Status is
    begin
        Voter_Group.Listen; -- prints system output
        New_Line;
        Proc_Group.Status;  -- prints processor fault status post cycle
        Voter_Group.Status; -- prints voter fault status post cycle
    end Status;
    -- simulator object
    package NMR_Sim is new Simulator
        (Cycle_Limit => Clock,
         System_Inputs => Inputs,
         Input_Generator => Generate,
         Cycle => Cycle,
         Status => Status);
begin
    -- init float pointers
    Processor.Init_Array(Proc_Array);
    Voter.Init_Array(Voter_Array);
    Init_Array(Inputs);
    
    -- system inputs to processors
    Proc_Group.Bind_To(Inputs, 1);
    
    -- bind all processors to each voter
    for Vtr of Voter_Array
    loop
        Proc_Group.Bind_From(Vtr.Input);
    end loop;
    
    -- let it rip
    NMR_Sim.Run_Simulator;
end NMR_Simulator;
