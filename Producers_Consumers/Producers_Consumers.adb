--
-- Implementation of the producer consumer problem
-- ...in Ada?
-- Really interesting language which makes a lot of sense
-- raise Index_From_1_Exception
--

with Ada.Text_Io, Synchronization, Queue; 
use Ada.Text_Io, Synchronization;

procedure Producers_Consumers is
    -- producer consumer constant values
    Num_Producers : constant Integer := 4;
    Num_Consumers : constant Integer := 4;
    Output : constant String := "Hello World ";
    Time   : constant Duration := 0.1;
    Finish : constant Natural := 1;
    
    -- task data declarations / initializations
    type Product is record
        Content : String (1 .. Output'Length);
        Length  : Integer;
        I       : Integer;
    end record;
    Message : aliased Product := (Content => Output, Length => Output'Length, I => 1);
    package Buffer is new Queue(T => Character, Length => Message.Length);
    
    -- synchronization structures
    Hold : Mutex := new Mutex_T;
    Empty : Semaphore := new Semaphore_T(Start => Message.Length - 1);
    Occupied : Semaphore := new Semaphore_T(Start => 0);
    Kill : Signal := new Signal_T(Start => 0);
    
    -- task specs
    task type Production 
        (Hold : Mutex;
         Empty, Occupied : Semaphore;
         Kill : Signal;
         Message : access Product);

    task type Consumption 
        (Hold : Mutex; 
         Empty, Occupied : Semaphore;
         Kill : Signal);
    
    -- task declarations
    Producers : array (1 .. Num_Producers) of Production
        (Hold    => Hold, 
         Empty   => Empty, Occupied => Occupied, 
         Kill    => Kill, 
         Message => Message'access);
                   
    Consumers : array (1 .. Num_Consumers) of Consumption
        (Hold  => Hold, 
         Empty => Empty, Occupied => Occupied,
         Kill  => Kill);
    
    -- task bodies
    task body Production is
        Break : Natural;
    begin
        loop
            -- gain access to buffer and message
            Empty.Wait;
            Hold.Lock;
            
            begin
                -- produce value
                Buffer.Enqueue(Message.Content(Message.I));
            exception
                -- exception handler to validate implementation
                when Buffer.Overflow_Exception =>
                    Put_Line("Producer Overflow");
            end;
            
            Message.I := (Message.I mod Message.Length) + 1;
            
            -- allow next to access buffer and message
            Hold.Unlock;
            Occupied.Post;
            
            -- check if must to exit loop
            Kill.Poll(Break);
            exit when Break = Finish;
        end loop;
    end Production;
    
    task body Consumption is
        Break : Natural;
    begin
        loop
            -- gain access to buffer
            Occupied.Wait;
            Hold.Lock;
            
            begin
                -- consume value
                Put(Buffer.Dequeue);
            exception 
                -- exception handler to validate implementation
                when Buffer.Underflow_Exception =>
                    Put_Line("Consumer Underflow");
            end;                
            
            -- allow next to access buffer
            Hold.Unlock;
            Empty.Post;
        
            -- check if must to exit loop
            Kill.Poll(Break);
            exit when Break = Finish;
        end loop;
    end Consumption;
begin
    -- let tasks work
    delay Time;
    
    -- terminate tasks
    Kill.Set(Finish);
end Producers_Consumers;
