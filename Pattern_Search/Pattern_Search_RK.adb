
package body Pattern_Search_RK is
    -- accepts all printable ascii characters
    function Search (Text, Pattern : in String; Prime : in Positive) return Positive is
        N : Positive := Text'Length;
        M : Positive := Pattern'Length;
        Hash, Previous, Offset : Integer := 0;
    begin
        for I in 1 .. M
        loop
            Hash := Horners_Rule(Pattern(I), Hash, Prime);
            Previous := Horners_Rule(Text(I), Previous, Prime);
        end loop;
        
        for C of Hash'Image
        loop
            Offset := Offset + 1;
        end loop;
        
        for I in M+1 .. N
        loop
            Previous := Rolling_Hash(Text(I-M), Text(I), Previous, 10**Offset, Prime);
            if Previous = Hash and Check(Text, Pattern, I-M) then
                return I-M;
            end if;
        end loop;
        
        return N;
    end Search;
    
    function Horners_Rule(Trail : in Character; Previous : in Integer; Prime : in Positive) return Integer is
    begin
        return (Previous*10+Character'Pos(Trail)) mod Prime; 
    end Horners_Rule;
    
    function Rolling_Hash(Lead, Trail : in Character; Previous : in Integer; Offset, Prime : in Positive) return Integer is
    begin
        return ((Previous-Character'Pos(Lead)*Offset)*10+Character'Pos(Trail)) mod Prime;
    end Rolling_Hash;
    
    function Check(Text, Pattern : in String; Start : in Positive) return Boolean is
    begin
        for I in 1 .. Pattern'Length
        loop
            if Pattern(I) /= Text(Start+I) then
                return False;
            end if;
        end loop;
        
        return True;
    end Check;
end Pattern_Search_RK;
