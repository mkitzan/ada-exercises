
package body Leagues is
	function New_League(Name : Name_String) return League is
		L : League;
	begin
		L.Name := Name;
		return l;
	end New_League;
	
	
	function Get_Name(L : in League) return Name_String is
	begin
		return L.Name;
	end Get_Name;
	
	
	function Get_Size(L : in League) return Natural is
	begin
		return L.Size;
	end Get_Size;
	
	
	procedure Add_Team(L : out League; T : in Team) is
	begin
		L.Teams(L.Size) := T;
		L.Size := L.Size + 1;
	end Add_Team;
	
	
	function  Remove_Team(L : in out League; Name : in Name_String) return Boolean is
		Found : Boolean := False;
	begin
		for I in 1 .. L.Size
		loop
			if Found then
				-- shuffle down values to overwrite removed team
				L.Teams(I-1) := L.Teams(I);
			elsif Get_Name(L.Teams(I)) = Name then
				-- key team found
				Found := True;
			end if;
		end loop;
		
		-- adjust league's size
		L.Size := L.Size - 1;
		
		return Found;
	end Remove_Team;
end Leagues;
