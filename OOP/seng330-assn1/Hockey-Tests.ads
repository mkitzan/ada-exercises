with Ada.Assertions, Ada.Text_IO; use Ada.Assertions, Ada.Text_IO;
with Hockey.League, Hockey.Team, Hockey.Player;
use  Hockey.League, Hockey.Team, Hockey.Player;

package Hockey.Tests is
    procedure Test_Player_Constructor;
    procedure Test_Team_Constructor;
    procedure Test_League_Constructor;
    
    procedure Test_Team_Add;
    procedure Test_League_Add;
    
    procedure Test_Team_Remove;
    procedure Test_Team_Remove_Empty;
    procedure Test_Team_Remove_Missing;
    
    procedure Test_League_Remove;
    procedure Test_League_Remove_Empty;
    procedure Test_League_Remove_Missing;
    
    procedure Test_All;
end Hockey.Tests;
