
package body Hockey.Tests is
	procedure Test_Player_Constructor is
		P : Player_T := New_Player(Name   => "McDavid", 
								   Points => 108, 
								   Role   => Position'(CENTER));
	begin
		Assert(Get_Name(P) = "McDavid" and Get_Points(P) = 108);
		Put_Line("Player constructor passed");
	end Test_Player_Constructor;
	
	
	procedure Test_Team_Constructor is
		T : Team_T := New_Team("Oilers");
	begin
		Assert(Get_Name(T) = "Oilers" and Get_Size(T) = 0);
		Put_Line("Team   constructor passed");
	end Test_Team_Constructor;
	
	
	procedure Test_League_Constructor is
		L : League_T := New_League("NHL");
	begin
		Assert(Get_Name(L) = "NHL" and Get_Size(L) = 0);
		Put_Line("League constructor passed");
	end Test_League_Constructor;
	
	
	procedure Test_Team_Add is
		T  : Team_T   := New_Team("Oilers");
		P1 : Player_T := New_Player(Name   => "McDavid", 
								    Points => 108, 
								    Role   => Position'(CENTER));
		P2 : Player_T := New_Player(Name   => "Draisaitl", 
								    Points => 70, 
								    Role   => Position'(CENTER));
		P3 : Player_T := New_Player(Name   => "Talbot", 
									Points => 0,
								    Role   => Position'(GOALTENDER));
	begin
		Add_Player(T => T, P => P1);
		Add_Player(T => T, P => P2);
		Add_Player(T => T, P => P3);
		
		Assert(Get_Points(T) = 178 and Get_Size(T) = 3);
		Put_Line("Team   add passed");
	end Test_Team_Add;
	
	
	procedure Test_League_Add is
		L  : League_T := New_League("NHL");
		T1 : Team_T   := New_Team("Oilers");
		T2 : Team_T   := New_Team("Flames");
		T3 : Team_T   := New_Team("Canucks");
	begin
		Add_Team(L => L, T => T1);
		Add_Team(L => L, T => T2);
		Add_Team(L => L, T => T3);
		
		Assert(Get_Size(L) = 3);
		Put_Line("League add passed");
	end Test_League_Add;
	
	
	procedure Test_Team_Remove is
		T  : Team_T   := New_Team("Oilers");
		P1 : Player_T := New_Player(Name   => "McDavid", 
								    Points => 108, 
								    Role   => Position'(CENTER));
		P2 : Player_T := New_Player(Name   => "Draisaitl", 
								    Points => 70, 
								    Role   => Position'(CENTER));
		P3 : Player_T := New_Player(Name   => "Talbot", 
									Points => 0,
								    Role   => Position'(GOALTENDER));
		Worked : Boolean;
	begin
		Add_Player(T => T, P => P1);
		Add_Player(T => T, P => P2);
		Add_Player(T => T, P => P3);
		Worked := Remove_Player(T => T, Name => "McDavid");
		
		Assert(Get_Points(T) = 70 and Get_Size(T) = 2 and Worked);
		Put_Line("Team   remove passed");
	end Test_Team_Remove;
	
	
	procedure Test_League_Remove is
		L  : League_T := New_League("NHL");
		T1 : Team_T   := New_Team("Oilers");
		T2 : Team_T   := New_Team("Flames");
		T3 : Team_T   := New_Team("Canucks");
		Worked : Boolean;
	begin
		Add_Team(L => L, T => T1);
		Add_Team(L => L, T => T2);
		Add_Team(L => L, T => T3);
		Worked := Remove_Team(L => L, Name => "Flames");
		
		Assert(Get_Size(L) = 2 and Worked);
		Put_Line("League remove passed");
	end Test_League_Remove;
	
	
	procedure Test_All is
	begin
		Test_Player_Constructor;
		Test_Team_Constructor;
		Test_League_Constructor;
		New_Line;
	
		Test_Team_Add;
		Test_League_Add;
		New_Line;
	
		Test_Team_Remove;
		Test_League_Remove;
		New_Line;
	end Test_All;
end Hockey.Tests;
