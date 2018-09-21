
package body Hockey.Player is
	function New_Player(Name : in String; Points : in Natural; Role : in Position) return Player_T is
		P : Player_T := Player_T'(Name => To_Unbounded_String(Name), Points => Points, Role => Role);
	begin
		return P;
	end New_Player;
	
	
	function Get_Name(P : in Player_T) return String is
	begin
		return To_String(P.Name);
	end Get_Name;
	
	
	function Get_Points(P : in Player_T) return Natural is
	begin
		return P.Points;
	end Get_Points;
	
	
	procedure Set_Points(P : out Player_T; Points : in Natural) is 
	begin
		P.Points := Points;
	end Set_Points;
	
	
	procedure Add_Points(P : out Player_T; Points : in Natural) is
	begin
		P.Points := P.Points + Points;
	end Add_Points;
	
	
	procedure Reset_Points(P : out Player_T) is
	begin
		P.Points := 0;
	end Reset_Points;
end Hockey.Player;
