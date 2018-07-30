with Ada.Text_IO, Ada.Numerics.Discrete_Random; use Ada.Text_IO;

procedure Simulator is
    Clock        : Positive := 5; -- time steps to simulate
    Proc_Inputs  : Positive := 1; -- incoming connections to processors
    Voter_Inputs : Positive := 3; -- incoming connections to voters (== number of processors)
    Voter_Count  : Positive := 3; -- number of voters in system (every proc connects to every voter)
    Fault_Mask   : Float := 0.25; -- filter value over faulty module output
    
    -- simulator value types
    type Float_Access is access Float;
    type Float_Array is array (Positive range <>) of Float_Access;
    
    -- simulator structures
    type Module (Inputs : Positive) is record
        Faulty : Boolean := False;
        Input  : Float_Array(1 .. Inputs);
        Output : Float_Access;
    end record;
    
    subtype Processor is Module(Proc_Inputs);
    subtype Voter is Module(Voter_Inputs);
    
    type Proc_Array is array (Positive range <>) of Processor;
    type Voter_Array is array (Positive range <>) of Voter;
    
    -- simulator operations
    procedure Process (Component : in out Processor) is
    begin
        Component.Output.all := Component.Input(1).all;
        
        -- compute fault filter
        if Component.Faulty then
            Component.Output.all := Component.Output.all * Fault_Mask;
        end if;
    end Process;
    
    procedure Vote (Component : in out Voter) is
        Total : Float := 0.00;
        Diff  : Float;
    begin
        for Value of Component.Input
        loop
            Total := Total + Value.all;
        end loop;
        
        -- mid value selection
        Total := Total / Float(Component.Input'Last);
        Diff := abs (Total - Component.Input(1).all);
        Component.Output.all := Component.Input(1).all;
        
        for I in 2 .. Component.Input'Last
        loop
            if Diff > abs (Total - Component.Input(I).all) then
                Diff := abs (Total - Component.Input(I).all);
                Component.Output.all := Component.Input(1).all;
            end if;
        end loop;
        
        -- compute fault filter
        if Component.Faulty then
            Component.Output.all := Component.Output.all * Fault_Mask;
        end if;
    end Vote;
    
    -- output -> input pointer binding
    procedure Bind (Max : in Positive; From : in Proc_Array; To : out Float_Array) is
    begin
        for I in 1 .. Max
        loop
            To(I) := From(I).Output;
        end loop;
    end Bind;

    -- module containers
    Procs  : Proc_Array(1 .. Voter_Inputs);
    Voters : Voter_Array(1 .. Voter_Count);
    Seed   : Float_Array(1 .. Voter_Inputs);
    
    -- random processor input generator
    subtype Seed_Range is Integer range 1 .. 5;
    Seed_Values : array (1 .. 5) of Float := (0.8, 0.85, 0.9, 0.95, 1.0);
    package Random_Seed is new Ada.Numerics.Discrete_Random(Seed_Range);
    use Random_Seed;
    G : Generator;
begin

    -- Initialize system
    for I in 1 .. Voter_Inputs
    loop
        Seed(I) := new Float;
        Procs(I).Input(1) := Seed(I);
        Procs(I).Output := new Float;
        
        -- Set even numbered processors to faulty
        if I mod 2 = 0 then
            Procs(I).Faulty := True;
        end if;
    end loop;
    
    -- Bind outputs to inputs
    for I in 1 .. Voter_Count
    loop
        Voters(I).Output := new Float;
        Bind(Voter_Inputs, Procs, Voters(I).Input);
        
        -- Set even numbered voters to faulty
        if I mod 2 = 0 then
            Voters(I).Faulty := True;
        end if;
    end loop;
    
    -- Simulator
    for I in 1 .. Clock
    loop
        -- generate random processor inputs
        for Sd of Seed
        loop
            Sd.all := Seed_Values(Random(G));
            Reset(G);
        end loop;
        
        -- simulate processing inputs
        for Component of Procs
        loop
            Process(Component);
        end loop;
        
        -- simulate voting procedure
        for Component of Voters
        loop
            Vote(Component);
            Put(Component.Output.all'Image & " ");
        end loop;
        
        New_Line;
    end loop;
end Simulator;
