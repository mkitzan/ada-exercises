--
-- Package specs for generic stack
--

generic
    -- arguments for package instantiation
    type T is private;
    Length : Integer;
package Stack is
    -- exception declarations
    Underflow_Exception, Overflow_Exception : exception;

    -- operation specs
    procedure Push     (Item : in  T); -- raises Overflow_Exception
    function  Pop      return T; -- raises Underflow_Exception
    function  Is_Empty return Boolean;
    procedure Reset;
end Stack;
