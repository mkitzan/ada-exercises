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
    procedure Enqueue (Value : in  T);
    function  Dequeue return T;
    procedure Clear;
end Queue;
