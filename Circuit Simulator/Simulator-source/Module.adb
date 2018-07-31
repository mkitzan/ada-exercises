with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package body Module is
    procedure Init_Module (Component : in out Module) is
    begin
        Component.Output     := new Float;
        Component.Output.all := 0.0000;
    end Init_Module;
end Module;
