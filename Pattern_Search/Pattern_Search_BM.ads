
package Pattern_Search_BM is
    -- accepts all printable ascii characters
    type Right is array (Character range <>) of Integer;
    
    function Search (Text, Pattern : in String) return Positive;
private
    procedure Build_Right(Right_Array : in out Right; Pattern : in String);
end Pattern_Search_BM;
