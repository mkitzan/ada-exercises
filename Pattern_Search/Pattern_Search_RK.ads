
package Pattern_Search_RK is
    -- accepts all printable ascii characters
    function Search (Text, Pattern : in String; Prime : in Positive) return Positive;
private
    function Horners_Rule(Trail : in Character; Previous : in Integer; Prime : in Positive) return Integer;
    function Rolling_Hash(Lead, Trail : in Character; Previous : in Integer; Offset, Prime : in Positive) return Integer;
    function Check(Text, Pattern : in String; Start : in Positive) return Boolean;
end Pattern_Search_RK;
