with Ada.Text_IO; use Ada.Text_IO;

procedure Simulator is
    Count : Positive := 3;
    Proc_Inputs : Positive := 1;
    Voter_Inputs : Positive := 3;
    Mask : Float := 0.25;
    
    type Float_Access is access Float;
    type Float_Array is array (Positive range <>) of Float_Access;
    
    type Module (Inputs : Positive) is record
        Faulty : Boolean := False;
        Input  : Float_Array(1 .. Inputs);
        Output : Float_Access;
    end record;
    
    subtype Processor is Module(Proc_Inputs);
    subtype Voter is Module(Voter_Inputs);
    
    type Proc_Array is array (Positive range <>) of Processor;
    type Voter_Array is array (Positive range <>) of Voter;
    
    procedure Process (Component : in out Processor) is
    begin
        Component.Output.all := Component.Input(1).all;
        
        if Component.Faulty then
            Component.Output.all := Component.Output.all * Mask;
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
                
        if Component.Faulty then
            Component.Output.all := Component.Output.all * Mask;
        end if;
    end Vote;
    
    procedure Bind (Max : in Positive; From : in Proc_Array; To : out Float_Array) is
    begin
        for I in 1 .. Max
        loop
            To(I) := From(I).Output;
        end loop;
    end Bind; 
    
    procedure Initialize(Component : in out Module) is
    begin
        Component.Output := new Float;
    end Initialize;

    Procs  : Proc_Array(1 .. Count);
    Voters : Voter_Array(1 .. Count);
    Seed : Float_Access := new Float;
begin
    Seed.all := 1.00;

    for I in 1 .. Count
    loop
        Initialize(Procs(I));
        Initialize(Voters(I));
        
        if I mod 2 = 0 then
            Procs(I).Faulty := True;
            Voters(I).Faulty := True;
        end if;
    end loop;
    
    for I in 1 .. Count
    loop
        Bind(Count, Procs, Voters(I).Input);
    end loop;
    
    for Component of Procs
    loop
        Component.Input(1) := Seed;
        Process(Component);
    end loop;
    
    for Component of Voters
    loop
        Vote(Component);
        Put(Component.Output.all'Image & " ");
    end loop;
    
    New_Line;
end Simulator;