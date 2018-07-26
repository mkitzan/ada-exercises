--
-- Package specs for generic queue
--

generic
    -- arguments for package instantiation
    type T is private;
    Length : Integer;
package Queue is
    -- exception declarations
    Underflow_Exception, Overflow_Exception : exception;

    -- operation specs
    procedure Enqueue  (Value : in  T); -- raises Overflow_Exception
    function  Dequeue  return T; -- raises Underflow_Exception
    function  Is_Empty return Boolean;
    procedure Reset;
end Queue;
