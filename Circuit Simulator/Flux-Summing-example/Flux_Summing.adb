with Ada.Text_IO; use Ada.Text_IO;
with Units, Simulator, Module, Module.Group; use Units;

procedure Flux_Summing is
    Clock              : Positive := 25; -- time steps to simulate
    Processor_Inputs   : Positive := 2;  -- incoming connections to processors
    Transformer_Inputs : Positive := 3;  -- incoming connections to transformer (== number of processors)
    Actuator_Inputs    : Positive := 1;  -- incoming connections to the actuator
    Repair_Time_Proc   : Integer := 3;  -- clock cycles until faulty component is repaired
    Repair_Time_None   : Integer := 0;
    Fault_Filter_Proc  : Float := 0.00;  -- filter value over faulty processor output
    Fault_Filter_None  : Float := 0.00;  -- filter value over faulty module output
    Fault_Grade_Proc   : Float := 0.025; -- probability of processor failure each cycle
    Fault_Grade_None   : Float := 0.00;  -- probability of module failure each cycle

    -- base module packages
    package Processor   is new Module (Inputs => Processor_Inputs);
    package Transformer is new Module (Inputs => Transformer_Inputs);
    package Actuator    is new Module (Inputs => Actuator_Inputs);
    Processor_Array   : Processor.Module_Array (1 .. Transformer_Inputs);
    Transformer_Array : Transformer.Module_Array (1 .. Actuator_Inputs);
    Actuator_Array    : Actuator.Module_Array (1 .. 1);
    -- system inputs
    Inputs : Float_Array(1 .. Transformer_Inputs);
    
    -- processor operation
    procedure Process (Component : in out Processor.Module) is
    begin
        -- Output = given input * (previous output / actuator feedback)
        Component.Output.all := Component.Input(1).all * (Component.Output.all / Component.Input(2).all);
    end Process;
    
    -- transformer operation
    procedure Transform (Component : in out Transformer.Module) is
    begin
        Component.Output.all := 0.00;
        -- sum transformer's inputs into single output
        for Value of Component.Input
        loop
            Component.Output.all := Component.Output.all + Value.all;
        end loop;
    end Transform;
    
    -- actuator operation
    procedure Actuate (Component : in out Actuator.Module) is
    begin
        -- compute the proportion of each processor contributions (feedback)
        Component.Output.all := Component.Input(1).all / Float(Transformer_Inputs);
    end Actuate;
    
    -- create module groups
    package Processor_Group is new Processor.Group
        (Module_Group => Processor_Array, 
         Repair_Time  => Repair_Time_Proc, 
         Fault_Grade  => Fault_Grade_Proc, 
         Fault_Filter => Fault_Filter_Proc, 
         Operation    => Process);
    package Transformer_Group is new Transformer.Group
        (Module_Group => Transformer_Array,
         Repair_Time  => Repair_Time_None,
         Fault_Grade  => Fault_Grade_None, 
         Fault_Filter => Fault_Filter_None, 
         Operation    => Transform);
    package Actuator_Group is new Actuator.Group
        (Module_Group => Actuator_Array, 
         Repair_Time  => Repair_Time_None, 
         Fault_Grade  => Fault_Grade_None, 
         Fault_Filter => Fault_Filter_None, 
         Operation    => Actuate);
         
    -- a single cycle of the system
    procedure Cycle is
    begin
        -- simulator automatically generates new vlaues for system inputs
        Processor_Group.Run;  -- process new input
        Transformer_Group.Run; -- votes on processor output
        Actuator_Group.Run;
    end Cycle;
    
    -- system status survey
    procedure Status is
    begin
        Transformer_Group.Listen; -- prints system output
        New_Line;
        Processor_Group.Status;  -- prints processor fault status post cycle
    end Status;
    
    -- simulator object
    package Flux_Sim is new Simulator
        (Cycle_Limit     => Clock,
         System_Inputs   => Inputs,
         Input_Range     => (0.3313, 0.3323, 0.3333, 0.3343, 0.3353),
         Cycle           => Cycle,
         Status          => Status);
begin
    -- init group outputs
    Init_Array(Inputs);
    Processor_Group.Init_Group(Value => 1.0);
    Transformer_Group.Init_Group(Value => 1.0);
    Actuator_Group.Init_Group(Value => 1.0);
    
    -- bind system inputs to processors
    Processor_Group.Bind_Array(Inputs, 1);
    -- bind all processors to transformer
    Transformer_Group.Bind_Multi(Processor_Group.Outputs, 1);
    -- bind transformer to actuator
    Actuator_Group.Bind_Array(Transformer_Group.Outputs, 1);
    -- feedback actuator to processors
    Processor_Group.Bind_Single(Actuator_Group.Outputs(1), 2);
    
    -- let it rip
    Flux_Sim.Run_Simulator;
end Flux_Summing;
