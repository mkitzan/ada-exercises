with Types, Teams; use Types, Teams;

package Leagues is
	type League is tagged private;
	type League_Array is array (Positive range <>) of Team;
	
	-- constructors
	function New_League(Name : Name_String) return League;
	
	-- getters
	function Get_Name(L : in League) return Name_String;
	function Get_Size(L : in League) return Natural;
	
	-- augmentors
	procedure Add_Team(L : out League; T : in Team);
	function  Remove_Team(L : in out League; Name : in Name_String) return Boolean;
private
	type League is tagged
	record
		Name  : Name_String;
		Teams : Team_Array(1 .. Max_Teams);
		Size  : Natural := 0; 
	end record;
end Leagues;
