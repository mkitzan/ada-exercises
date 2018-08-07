
package body Pattern_Search_BM is
    function Search (Text, Pattern : in String) return Positive is
        Right_Array : Right(' ' .. '~');
        N : Positive := Text'Length;
        M : Positive := Pattern'Length;
        I : Positive := 1;
        Skip : Integer;
    begin
        Build_Right(Right_Array, Pattern);
        
        while I <= N-M
        loop
            Skip := 0;
            
            for J in reverse 1 .. M
            loop
                if Pattern(J) /= Text(I+J-1) then
                    if J-Right_Array(Text(I+J-1)) < 1 then 
                        Skip := 1;
                    else 
                        Skip := J-Right_Array(Text(I+J-1));
                    end if;
                    
                    exit;
                end if;
            end loop;
            
            if Skip = 0 then
                return I - 1;
            end if;
            
            I := I + Skip;
        end loop;
        
        return N;
    end Search;

    procedure Build_Right (Right_Array : in out Right; Pattern : in String) is
    begin
        for C in Right_Array'range
        loop
            Right_Array(C) := 0;
        end loop;
        
        for I in Pattern'range
        loop
            Right_Array(Pattern(I)) := I;
        end loop;
    end Build_Right;
end Pattern_Search_BM;
