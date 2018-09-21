
package body Hockey.League is
	function New_League(Name : String) return League_T is
		L : League_T;
	begin
		L.Name := To_Unbounded_String(Name);
		return L;
	end New_League;
	
	
	function Get_Name(L : in League_T) return String is
	begin
		return To_String(L.Name);
	end Get_Name;
	
	
	function Get_Size(L : in League_T) return Natural is
	begin
		return L.Size - 1;
	end Get_Size;
	
	
	procedure Add_Team(L : out League_T; T : in Team_T) is
	begin
		L.Teams(L.Size) := T;
		L.Size := L.Size + 1;
	end Add_Team;
	
	
	function  Remove_Team(L : in out League_T; Name : in String) return Boolean is
		Found : Boolean := False;
	begin
		for I in 1 .. L.Size
		loop
			if Found then
				-- shuffle down values to overwrite removed team
				L.Teams(I-1) := L.Teams(I);
			elsif Get_Name(L.Teams(I)) = Name then
				-- key team found, adjust league's size
				Found := True;
				L.Size := L.Size - 1;
			end if;
		end loop;
		
		return Found;
	end Remove_Team;
end Hockey.League;
