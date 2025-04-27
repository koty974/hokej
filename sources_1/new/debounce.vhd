library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    Port (
        clk     : in  STD_LOGIC;
        btn_in  : in  STD_LOGIC;
        btn_out : out STD_LOGIC  := '0'
    );
end debounce;

architecture Behavioral of debounce is
    constant COUNTER_MAX : integer := 2_000_000;  -- cca 20ms pri 100MHz
    signal counter : integer range 0 to COUNTER_MAX := 0;
    signal btn_sync : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if btn_in /= btn_sync then
                counter <= 0;
                btn_sync <= btn_in;
            elsif counter < COUNTER_MAX then
                counter <= counter + 1;
            end if;

            if counter = COUNTER_MAX then
                btn_out <= btn_sync;
            end if;
        end if;
    end process;
end Behavioral;
