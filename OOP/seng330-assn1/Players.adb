
package body Players is
	function New_Player(Name : in Name_String; Points : in Natural; Role : in Position) return Player is
		P : Player := Player'(Name => Name, Points => Points, Role => Role);
	begin
		return P;
	end New_Player;
	
	
	function Get_Name(P : in Player) return Name_String is
	begin
		return P.Name;
	end Get_Name;
	
	
	function Get_Points(P : in Player) return Natural is
	begin
		return P.Points;
	end Get_Points;
	
	
	procedure Set_Points(P : out Player; Points : in Natural) is 
	begin
		P.Points := Points;
	end Set_Points;
	
	
	procedure Add_Points(P : out Player; Points : in Natural) is
	begin
		P.Points := P.Points + Points;
	end Add_Points;
	
	
	procedure Reset_Points(P : out Player) is
	begin
		P.Points := 0;
	end Reset_Points;
end Players;
