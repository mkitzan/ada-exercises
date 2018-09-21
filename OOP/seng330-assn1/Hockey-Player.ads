
package Hockey.Player is
	type Player_T is tagged private;
	type Player_Array is array (Positive range <>) of Player_T;
	
	-- constructors
	function New_Player(Name : in String; Points : in Natural; Role : in Position) return Player_T;
	
	-- getters
	function Get_Name(P : in Player_T)   return String;
	function Get_Points(P : in Player_T) return Natural;
	
	-- augmentors
	procedure Set_Points(P : out Player_T; Points : in Natural);
	procedure Add_Points(P : out Player_T; Points : in Natural);
	procedure Reset_Points(P : out Player_T);
private
	type Player_T is tagged
	record
		Name   : Unbounded_String;
		Points : Natural := 0;
		Role   : Position;
	end record;
end Hockey.Player;
