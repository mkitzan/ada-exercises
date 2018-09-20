
package body Teams is
	function New_Team(Name : in Name_String) return Team is
		T : Team;
	begin
		T.Name := Name;
		return T;
	end New_Team;
	
	
	function Get_Name(T : in Team) return Name_String is
	begin
		return T.Name;
	end Get_Name;
	
	
	function Get_Points(T : in Team) return Natural is
		Points : Natural := 0;
	begin
		for P of T.Players
		loop
			Points := Points + Get_Points(P);
		end loop;
		
		return Points;
	end Get_Points;
	
	
	function Get_Size(T : in Team) return Natural is
	begin
		return T.Size;
	end Get_Size;
	
	
	procedure Add_Player(T : out Team; P : in Player) is
	begin
		T.Players(T.Size) := P;
		T.Size := T.Size + 1;
	end Add_Player;
	
	
	function  Remove_Player(T : in out Team; Name : in Name_String) return Boolean is
		Found : Boolean := False;
	begin
		for I in 1 .. T.Size
		loop
			if Found then
				-- shuffle down values to overwrite removed player
				T.Players(I-1) := T.Players(I);
			elsif Get_Name(T.Players(I)) = Name then
				-- key player found
				Found := True;
			end if;
		end loop;
		
		-- adjust team's size
		T.Size := T.Size - 1;
		
		return Found;
	end Remove_Player;
end Teams;
