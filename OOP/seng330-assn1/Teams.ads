with Types, Players; use Types, Players;

package Teams is
	type Team is tagged private;
	type Team_Array is array (Positive range <>) of Team;
	
	-- constructors
	function New_Team(Name : in Name_String) return Team;
	
	-- getters
	function Get_Name(T : in Team) return Name_String;
	function Get_Points(T : in Team) return Natural;
	function Get_Size(T : in Team) return Natural;
	
	-- augmentors
	procedure Add_Player(T : out Team; P : in Player);
	function  Remove_Player(T : in out Team; Name : in Name_String) return Boolean;
private
	type Team is tagged
	record
		Name    : Name_String;
		Players : Player_Array(1 .. Max_Players);
		Size    : Natural := 0;
	end record;
end Teams;
