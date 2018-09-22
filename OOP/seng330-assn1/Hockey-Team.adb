
package body Hockey.Team is
	function New_Team(Name : in String) return Team_T is
		T : Team_T;
	begin
		T.Name := To_Unbounded_String(Name);
		return T;
	end New_Team;
	
	
	function Get_Name(T : in Team_T) return String is
	begin
		return To_String(T.Name);
	end Get_Name;
	
	
	function Get_Points(T : in Team_T) return Natural is
		Points : Natural := 0;
	begin
		for P of T.Players
		loop
			Points := Points + Get_Points(P);
		end loop;
		
		return Points;
	end Get_Points;
	
	
	function Get_Size(T : in Team_T) return Natural is
	begin
		return T.Size - 1;
	end Get_Size;
	
	
	procedure Add_Player(T : out Team_T; P : in Player_T) is
	begin
		T.Players(T.Size) := P;
		T.Size := T.Size + 1;
	end Add_Player;
	
	
	function  Remove_Player(T : in out Team_T; Name : in String) return Boolean is
		Found : Boolean := False;
	begin
		for I in 1 .. T.Size
		loop
			if Found then
				-- shuffle down values to overwrite removed player
				T.Players(I-1) := T.Players(I);
			elsif Get_Name(T.Players(I)) = Name then
				-- key player found, adjust team's size
				Found := True;
				T.Size := T.Size - 1;
			end if;
		end loop;
		
		return Found;
	end Remove_Player;
end Hockey.Team;
