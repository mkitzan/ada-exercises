with Types; use Types;

package Players is
	type Player is tagged private;
	type Player_Array is array (Positive range <>) of Player;
	
	-- constructors
	function New_Player(Name : in Name_String; Points : in Natural; Role : in Position) return Player;
	
	-- getters
	function Get_Name(P : in Player)   return Name_String;
	function Get_Points(P : in Player) return Natural;
	
	-- augmentors
	procedure Set_Points(P : out Player; Points : in Natural);
	procedure Add_Points(P : out Player; Points : in Natural);
	procedure Reset_Points(P : out Player);
private
	type Player is tagged
	record
		Name   : Name_String;
		Points : Natural := 0;
		Role   : Position;
	end record;
end Players;
