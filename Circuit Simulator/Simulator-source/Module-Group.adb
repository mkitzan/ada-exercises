with Ada.Text_IO, Ada.Numerics.Float_Random, Units; use Ada.Text_IO, Ada.Numerics.Float_Random, Units;

package body Module.Group is
    procedure Init_Group (Value : in Float) is
    begin
        for I in 1 .. Module_Group'Length
        loop
            Module_Group(I).Output     := new Float;
            Module_Group(I).Output.all := Value;
            Outputs(I) := Module_Group(I).Output;
        end loop;
    end Init_Group;

    procedure Run is 
    begin
        for Component of Module_Group
        loop
            Operation(Component);
            Fault_Component(Component);
        end loop;
    end Run;
    
    procedure Fault_Component (Component : in out Module) is 
    begin
        if Component.Faulty then
            Component.Output.all := Component.Output.all * Fault_Filter;
        else
            if Random(G) < Fault_Grade then
                Component.Faulty := True;
            end if;
            
            Reset(G);
        end if;
    end Fault_Component;
    
    procedure Status is
    begin
        for Component of Module_Group
        loop
            Put(Component.Faulty'Image & " ");
        end loop;
        
        New_Line;
    end Status;
    
    procedure Listen is
    begin
        for Output of Outputs
        loop
            Put(Output.all'Image & " ");
        end loop;
        
        New_Line;
    end Listen;
    
    procedure Bind_Single (From : in Float_Access; Position : in Positive) is
    begin
        for Component of Module_Group
        loop
            Component.Input(Position) :=  From;
        end loop;
    end Bind_Single;
    
    procedure Bind_Array (From : in Float_Array; Position : in Positive) is
    begin
        for I in 1 .. From'Length
        loop
            Module_Group(I).Input(Position) :=  From(I);
        end loop;
    end Bind_Array;
    
    procedure Bind_Multi (From : in Float_Array; Position : in Positive) is
    begin
        for I in Position .. From'Length
        loop
            for Component of Module_Group
            loop
                Component.Input(I) := From(I);
            end loop;
        end loop;
    end Bind_Multi;
end Module.Group;
