with Hockey.Player; use Hockey.Player;

package Hockey.Team is
	type Team_T is tagged private;
	type Team_Array is array (Positive range <>) of Team_T;
	
	-- constructors
	function New_Team(Name : in String) return Team_T;
	
	-- getters
	function Get_Name(T : in Team_T) return String;
	function Get_Points(T : in Team_T) return Natural;
	function Get_Size(T : in Team_T) return Natural;
	
	-- augmentors
	procedure Add_Player(T : out Team_T; P : in Player_T);
	function  Remove_Player(T : in out Team_T; Name : in String) return Boolean;
private
	type Team_T is tagged
	record
		Name	: Unbounded_String;
		Players : Player_Array(1 .. Max_Players);
		Size	: Positive:= 1;
	end record;
end Hockey.Team;
