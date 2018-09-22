with Hockey.Team; use Hockey.Team;

package Hockey.League is
    type League_T is tagged private;
    type League_Array is array (Positive range <>) of Team_T;
    
    -- constructors
    function New_League(Name : String) return League_T;
    
    -- getters
    function Get_Name(L : in League_T) return String;
    function Get_Size(L : in League_T) return Natural;
    
    -- augmentors
    procedure Add_Team(L : out League_T; T : in Team_T);
    function  Remove_Team(L : in out League_T; Name : in String) return Boolean;
private
    type League_T is tagged
    record
        Name  : Unbounded_String;
        Teams : Team_Array(1 .. Max_Teams);
        Size  : Positive := 1; 
    end record;
end Hockey.League;
