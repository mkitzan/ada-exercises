--
-- package for a generic size union find
--      weighted:     rank
--      compression:  path halving
--      element type: integer
--

generic
    -- arguments for package instantiation
    Size : Integer;
package Union_Find is
    -- exception declarations
    Range_Exception : exception;

    -- operation specs
    procedure Union (A, B : in Integer); -- raises Range_Exception
    function  Find  (Key  : in Integer) return Integer; -- raises Range_Exception
    procedure Reset;
private
    procedure Validate (Key : in Integer);
end Union_Find;
