--
-- Package body for classic synchronization structures
--

package body Synchronization is
    -- bodies for synchronization structures
    protected body Mutex_T is
        procedure Unlock is
        begin
            Open := True;
        end Unlock;
        
        entry Lock when Open = True is
        begin
            Open := False;
        end Lock;
    end Mutex_T;
    
    protected body Semaphore_T is
        procedure Post is
        begin
            Value := Value + 1;
        end Post;
        
        entry Wait when Value > 0 is
        begin
            Value := Value - 1;
        end Wait;
    end Semaphore_T;
    
    protected body Signal_T is
        entry Poll (Output : out Natural) when Open is
        begin
            Output := Value;
        end Poll;
        
        entry Set (Input : in Natural) when Open is
        begin
            Open := False;
            Value := Input;
            Open := True;
        end Set;
    end Signal_T;
end Synchronization;
