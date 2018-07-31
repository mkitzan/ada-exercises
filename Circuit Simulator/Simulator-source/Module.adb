with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package body Module is
    procedure Init_Module (Component : in out Module) is
    begin
        Component.Output     := new Float;
        Component.Output.all := 0.0000;
    end Init_Module;
    
    procedure Init_Array (Components : in out Module_Array) is
    begin    
        for Component of Components
        loop
            Component.Output     := new Float;
            Component.Output.all := 0.0000;
        end loop;
    end Init_Array;
end Module;
