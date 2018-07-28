--
-- Package spec for generic quick sort
--

generic
    -- arguments for package instantiation
    type T is private;
    type T_Array is array (Integer range <>) of T;
    with function Compare (Left, Right : in T) return Boolean;
package Sort is
    -- operation specs
    procedure Quick     (Unsorted : in out T_Array);
    procedure Insertion (Unsorted : in out T_Array);
private
    procedure Swap      (Item_A, Item_B : in out T);
    function  Partition (Unsorted : in out T_Array; Lower, Upper : in Integer) return Integer;
end Sort;
