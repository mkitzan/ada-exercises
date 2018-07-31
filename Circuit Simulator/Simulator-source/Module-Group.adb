with Ada.Text_IO, Ada.Numerics.Float_Random, Units; use Ada.Text_IO, Ada.Numerics.Float_Random, Units;

package body Module.Group is
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
        for Component of Module_Group
        loop
            Put(Component.Output.all'Image & " ");
        end loop;
        
        New_Line;
    end Listen;
    
    procedure Bind_From(To : out Float_Array) is
    begin
        for I in 1 .. Module_Group'Length
        loop
            To(I) := Module_Group(I).Output;
        end loop;
    end Bind_From;
    
    procedure Bind_To(From : in Float_Array; Position : in Positive) is
    begin
        for I in 1 .. Module_Group'Length
        loop
            Module_Group(I).Input(Position) :=  From(I);
        end loop;
    end Bind_To;
end Module.Group;
