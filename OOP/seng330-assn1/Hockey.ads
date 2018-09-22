with Ada.Strings.Unbounded; 
use  Ada.Strings.Unbounded;

package Hockey is
    type Role is ( CENTER, GOALTENDER, WINGER, DEFENDER );
    Max_Players : Positive := 22; -- Standard hockey team size
    Max_Teams   : Positive := 32; -- 31 + Seattle Metropolitans
end Hockey;
