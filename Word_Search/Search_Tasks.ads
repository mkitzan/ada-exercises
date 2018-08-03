
package Search_Tasks is
    type Char_1D is array (Positive range <>) of Character;
    type Char_2D is array (Positive range <>, Positive range <>) of Character;
    
    protected type Signal_T (Start : Natural) is
        function   Poll return Natural; -- not entry, protected covers the read/write permissions
        procedure  Set  (Input : in Natural); -- not entry, protected covers the read/write permissions
    private
        Value : Natural := Start;
    end Signal_T;
    
    type Signal is access Signal_T;

    task type Forward    (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    task type Backward   (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    task type Up         (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    task type Down       (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    task type Left_Up    (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    task type Right_Up   (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    task type Left_Down  (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    task type Right_Down (Pattern : access Char_1D; Puzzle : access Char_2D; Kill : Signal);
    
    type Forward_Task is access Forward;
    type Backward_Task is access Backward;
    type Up_Task is access Up;
    type Down_Task is access Down;
    type Left_Up_Task is access Left_Up;
    type Right_Up_Task is access Right_Up;
    type Left_Down_Task is access Left_Down;
    type Right_Down_Task is access Right_Down;
    
    procedure Print_Location (SRow, SCol, ERow, ECol : in Integer);
end Search_Tasks;
