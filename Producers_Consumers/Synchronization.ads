--
-- Package spec for classic synchronization structures
-- Includes: semaphore, mutex, and signal
--

package Synchronization is
    -- specs for synchronization structures
    protected type Mutex_T is
        procedure Unlock;
        entry     Lock;
    private
        Open : Boolean := True;
    end Mutex_T;
    
    protected type Semaphore_T (Start : Natural) is
        procedure Post;
        entry     Wait;
    private 
        Value : Natural := Start;
    end Semaphore_T;
    
    protected type Signal_T (Start : Natural) is
        entry  Poll (Output : out Natural);
        entry  Set  (Input  : in  Natural);
    private
        Value : Natural := Start;
        Open  : Boolean := True;
    end Signal_T;
    
    -- "pointer" types to synchronization structures
    type Mutex     is access Mutex_T;
    type Semaphore is access Semaphore_T;
    type Signal    is access Signal_T;
end Synchronization;
