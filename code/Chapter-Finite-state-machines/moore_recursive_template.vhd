-- moore_recursive_template.vhd

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity moore_recursive_template is 
generic (
    param1 : std_logic_vector(...) := <value>;
    param2 : unsigned(...) := <value>
    );
port (
    clk, reset : in std_logic;
    input1, input2, ... : in std_logic_vector(...);
    -- inout is used here as we are reading output1 and output2
    new_output1, new_output2, output1, output2, ... : inout signed(...) 
);
end entity; 

architecture arch of moore_recursive_template is 
    type stateType is (s0, s1, s2, s3, ...);
    signal state_reg, state_next : stateType; 
    
    -- timer (optional)
    constant T1 : natural := <value>;
    constant T2 : natural := <value>;
    constant T3 : natural := <value>;
    ...
    constant tmax : natural := <value>; -- tmax >= max(T1, T2, ...)-1
    signal t : natural range 0 to tmax; 
    
    -- recursive : feedback register
    signal r1_reg, r1_next : std_logic_vector(...) := <value>;
    signal r2_reg, r2_next : signed(...) := <value>;
    ...
begin 
    -- state register : state_reg
    -- This process contains sequential part and all the D-FF are 
    -- included in this process. Hence, only 'clk' and 'reset' are 
    -- required for this process. 
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= s1;
        elsif (clk) then
            state_reg <= state_next;
        end if;
    end process; 
    
    -- timer (optional)
    process(clk, reset)
    begin 
        if reset = '1' then
            t <= 0;
        elsif rising_edge(clk) then
            if state_reg /= state_next then  -- state is changing
                t <= 0;
            elsif t /= tmax then
                t <= t + 1; 
            end if; 
        end if; 
    end process; 
    
    -- feedback registers: to feedback the outputs
    process(clk, reset)
    begin
        if (reset = '1') then
            r1_reg <= <initial_value>;
            r2_reg <= <initial_value>;
            ...
        elsif rising_edge(clk) then
            r1_reg <= r1_next;
            r2_reg <= r2_next;
            ...
        end if;
    end process; 
    
    -- next state logic : state_next
    -- This is combinational of the sequential design, 
    -- which contains the logic for next-state
    -- include all signals and input in sensitive-list except state_next
    process(input1, input2, state_reg) 
    begin 
        state_next <= state_reg; -- default state_next
        r1_next <= r1_reg; -- default next-states
        r2_next <= r2_reg;
        ...
        case state_reg is
            when s0 =>
                if <condition> and r1_reg = <value> and t >= T1-1 then -- if (input1 = '01') then
                    state_next <= s1; 
                    r1_next <= <value>;
                    r2_next <= <value>;
                    ...
                elsif <condition> and r2_reg = <value> and t >= T2-1 then  -- add all the required conditions
                    state_next <= <value>; 
                    r1_next <= <value>;
                    ...
                else -- remain in current state
                    state_next <= s0; 
                    r2_next <= <value>;
                    ...
                end if;
            when s1 => 
                ...
        end case;
    end process; 
        
    -- combination output logic
    -- This part contains the output of the design
    -- no if-else statement is used in this part
    -- include all signals and input in sensitive-list except state_next
    process(input1, input2, ..., state_reg) 
    begin
        -- default outputs
        output1 <= <value>;
        output2 <= <value>;
        ...
        case state_reg is 
            when s0 =>
                output1 <= <value>;
                output2 <= <value>;
                ...
            when s1 =>
                output1 <= <value>;
                output2 <= <value>;
                ...
            when s2 =>
                ...
        end case; 
    end process; 
        
    -- optional D-FF to remove glitches
    process(clk, reset)
    begin 
        if reset = '1' then 
            new_output1 <= ... ;
            new_output2 <= ... ;
        elsif rising_edge(clk) then
            new_output1 <= output1; 
            new_output2 <= output2; 
        end if;
    end process; 
end architecture; 