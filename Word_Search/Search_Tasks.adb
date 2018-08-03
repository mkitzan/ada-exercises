with Ada.Text_IO; use Ada.Text_IO;

package body Search_Tasks is
    protected body Signal_T is
        function Poll return Natural is
        begin
            return Value;
        end Poll;
        
        procedure Set (Input : in Natural) is
        begin
            Value := Input;
        end Set;
    end Signal_T;

    procedure Print_Location (SRow, SCol, ERow, ECol : in Integer) is
    begin
        Put_Line("Pattern founded starting (" & SRow'Image & "," & SCol'Image & ") and ending (" & ERow'Image & "," & ECol'Image & ")");
    end Print_Location;

    task body Forward is
        N : Positive := Puzzle'Length;
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in 1 .. N
        loop
            for J in 1 .. N
            loop
                Match := 0;
            
                for K in 1 .. M
                loop
                    exit when J+K-1 > N;
                    
                    if Pattern(K) = Puzzle(I, J+K-1) then
                        Match := Match + 1;
                        
                        if Match = M then
                            Print_Location(I-1, J-1, I-1, J+K-2);
                            Kill.Set(1);
                        end if;
                    end if;
                end loop;
                
                exit when Kill.Poll = 1; -- gormless task termination method, since it wasn't structured with entry/select statements
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Forward;
    
    task body Backward is
        N : Positive := Puzzle'Length(1);
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in 1 .. N
        loop
            for J in reverse 1 .. N
            loop
                Match := 0;
            
                for K in 1 .. M
                loop
                    exit when J-K+1 < 1;
                    if Pattern(K) = Puzzle(I, J-K+1) then
                        Match := Match + 1;
                        
                        if Match = M then
                            Print_Location(I-1, J-1, I-1, J-K);
                            Kill.Set(1);
                        end if;
                    end if;
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Backward;
    
    task body Up is
        N : Positive := Puzzle'Length(1);
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in 1 .. N
        loop
            for J in 1 .. N
            loop
                Match := 0;
            
                for K in 1 .. M
                loop
                    exit when J+K-1 > N;
                    
                    if Pattern(K) = Puzzle(J+K-1, I) then
                        Match := Match + 1;
                        
                        if Match = M then
                            Print_Location(J-1, I-1, J+M-1, I-1);
                            Kill.Set(1);
                        end if;
                    end if;
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Up;
    
    task body Down is
        N : Positive := Puzzle'Length(1);
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in 1 .. N
        loop
            for J in reverse 1 .. N
            loop
                Match := 0;
            
                for K in reverse 1 .. M
                loop
                    exit when J+K-1 > N;
                    
                    if Pattern(M-K+1) = Puzzle(J+K-1, I) then
                        Match := Match + 1;
                        
                        if Match = M then
                            Print_Location(J+M-2, I-1, J-1, I-1);
                            Kill.Set(1);
                        end if;
                    end if;
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Down;
    
    task body Left_Up is
        N : Positive := Puzzle'Length(1);
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in M .. N
        loop
            for J in 0 .. I-M
            loop
                Match := 0;
                
                for K in 0 .. M-1
                loop
                    if Pattern(K+1) = Puzzle(I-(J+K), J+K+1) then
                        Match := Match + 1;  
                        
                        if Match = M then
                            Print_Location(I-(J+K)+M-2, J+K+1-M, I-(J+K)-1, J+K);
                            Kill.Set(1);
                        end if;
                    end if;    
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
        
        for I in 1 .. N-M
        loop
            for J in 0 .. N-I-M
            loop
                Match := 0;
                
                for K in 0 .. M-1
                loop
                    if Pattern(K+1) = Puzzle(N-(J+K), (J+K+2)+(I-1)) then
                        Match := Match + 1;    
                        
                        if Match = M then
                            Print_Location(N-(J+K)+M-2, (J+K+2)+(I-1)-M, N-(J+K)-1, (J+K+2)+(I-1)-1);
                            Kill.Set(1);
                        end if;
                    end if;    
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Left_Up;

    task body Right_Up is
        N : Positive := Puzzle'Length(1);
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in M .. N
        loop
            for J in 0 .. I-M
            loop
                Match := 0;
                
                for K in 0 .. M-1
                loop
                    if Pattern(K+1) = Puzzle(I-K, N-(J+K)) then
                        Match := Match + 1;  
                        
                        if Match = M then
                            Print_Location(I-K+M-2, N-(J+K)+M-2, I-K-1, N-(J+K)-1);
                            Kill.Set(1);
                        end if;
                    end if;    
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Right_Up;

    task body Left_Down is
        N : Positive := Puzzle'Length(1);
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in M .. N
        loop
            for J in 0 .. I-M
            loop
                Match := 0;
                
                for K in 0 .. M-1
                loop
                    if Pattern(M-K) = Puzzle(I-(J+K), J+K+1) then
                        Match := Match + 1;  
                        
                        if Match = M then
                            Print_Location(I-(J+K)-1, J+K, I-(J+K)+M-2, J+K+1-M);
                            Kill.Set(1);
                        end if;
                    end if;    
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
        
        for I in 1 .. N-M
        loop
            for J in 0 .. N-I-M
            loop
                Match := 0;
                
                for K in 0 .. M-1
                loop
                    if Pattern(M-K) = Puzzle(N-(J+K), (J+K+2)+(I-1)) then
                        Match := Match + 1;    
                        
                        if Match = M then
                            Print_Location(N-(J+K)-1, (J+K+2)+(I-1)-1, N-(J+K)+M-2, (J+K+2)+(I-1)-M);
                            Kill.Set(1);
                        end if;
                    end if;    
                end loop;
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Left_Down;

    task body Right_Down is
        N : Positive := Puzzle'Length(1);
        M : Positive := Pattern'Length;
        Match : Natural;
    begin
        for I in M .. N
        loop
            for J in 0 .. I-M
            loop
                Match := 0;
                
                for K in 0 .. M-1
                loop
                    if Pattern(M-K) = Puzzle(I-K, N-(J+K)) then
                        Match := Match + 1;  
                        
                        if Match = M then
                            Print_Location(I-K-1, N-(J+K)-1, I-K+M-2, N-(J+K)+M-2);
                            Kill.Set(1);
                        end if;
                    end if;    
                end loop; 
                
                exit when Kill.Poll = 1;
            end loop;
            exit when Kill.Poll = 1;
        end loop;
    end Right_Down;
end Search_Tasks;
