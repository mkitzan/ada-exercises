with Ada.Text_IO, Ada.Command_Line, Ada.Sequential_IO, Search_Tasks;
use  Ada.Text_IO, Ada.Command_Line, Search_Tasks; 

procedure Word_Search is
    Input : File_Type;
    N, M : Positive;
    Puzzle  : access Char_2D;
    Pattern : access Char_1D;
    
    Kill : Signal := new Signal_T(0);
    
    Scan_Forward    : Forward_Task;
    Scan_Backward   : Backward_Task;
    Scan_Up         : Up_Task;
    Scan_Down       : Down_Task;
    Scan_Left_Up    : Left_Up_Task;
    Scan_Left_Down  : Left_Down_Task;
    Scan_Right_Up   : Right_Up_Task;
    Scan_Right_Down : Right_Down_Task;
begin
    if Argument_Count < 1 then
        return;
    end if;
    
    Open(File => Input, Mode => In_File, Name => Argument(1));
    N := Positive'Value(Get_Line(Input));
    M := Get_Line(Input)'Length;
    Puzzle  := new Char_2D(1 .. N, 1 .. N);
    Pattern := new Char_1D(1 .. M);
    Close(Input);
    
    Open(File => Input, Mode => In_File, Name => Argument(1));
    Skip_Line(Input);
    for I in 1 .. M
    loop
        Get(Input, Pattern(I));
        Put(Pattern(I));
    end loop;
    
    New_Line;
    New_Line;
    
    for I in 1 .. N
    loop
        for J in 1 .. N
        loop
            Get(Input, Puzzle(I, J));
            Put(Puzzle(I, J));
        end loop;
        New_Line;
    end loop;
    Close(Input);
    
    New_Line;
    
    Scan_Forward    := new Forward(Pattern, Puzzle, Kill);
    Scan_Backward   := new Backward(Pattern, Puzzle, Kill);
    Scan_Up         := new Up(Pattern, Puzzle, Kill);
    Scan_Down       := new Down(Pattern, Puzzle, Kill);
    Scan_Left_Up    := new Left_Up(Pattern, Puzzle, Kill);
    Scan_Left_Down  := new Left_Down(Pattern, Puzzle, Kill);
    Scan_Right_Up   := new Right_Up(Pattern, Puzzle, Kill);
    Scan_Right_Down := new Right_Down(Pattern, Puzzle, Kill);
    
    if Kill.Poll = 0 then
        Put_Line("Pattern not found");
    end if;
end Word_Search;
