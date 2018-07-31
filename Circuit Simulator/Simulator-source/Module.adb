with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package body Module is
    procedure Init_Module (Component : in out Module; Value : in Float) is
    begin
        Component.Output     := new Float;
        Component.Output.all := Value;
    end Init_Module;
end Module;
