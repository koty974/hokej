library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity power_plays is
    Port (
        clk100MHZ   : in  STD_LOGIC;
        SW0         : in  STD_LOGIC; -- 2min
        SW1         : in  STD_LOGIC; -- 4min
        SW2         : in  STD_LOGIC; -- 5min
        SW3         : in  STD_LOGIC; -- 10min
        BTNU        : in  STD_LOGIC; -- team 1
        BTND        : in  STD_LOGIC; -- team 2
        SW8         : in  STD_LOGIC; -- goal team 1
        SW5         : in  STD_LOGIC; -- goal team 2
        SW15        : in  STD_LOGIC; -- pause
        SW13        : in  STD_LOGIC; -- reset
        LED10       : out STD_LOGIC; -- team 2 LED MSB
        LED11       : out STD_LOGIC;
        LED12       : out STD_LOGIC;
        LED13       : out STD_LOGIC;
        LED14       : out STD_LOGIC; -- team 2 LED LSB
        LED1        : out STD_LOGIC; -- team 1 LED MSB
        LED2        : out STD_LOGIC;
        LED3        : out STD_LOGIC;
        LED4        : out STD_LOGIC;
        LED5        : out STD_LOGIC  -- team 1 LED LSB
    );
end power_plays;

architecture Behavioral of power_plays is

constant C_1MS : unsigned(16 downto 0) := to_unsigned(100_000, 17);
constant C_2MIN  : unsigned(31 downto 0) := to_unsigned(120_000, 32); -- in ms
constant C_4MIN  : unsigned(31 downto 0) := to_unsigned(240_000, 32);
constant C_5MIN  : unsigned(31 downto 0) := to_unsigned(300_000, 32);
constant C_10MIN : unsigned(31 downto 0) := to_unsigned(600_000, 32);

signal clk_1ms : std_logic := '0';
signal clk_count : unsigned(16 downto 0) := (others => '0');

signal counters : array(1 to 30) of unsigned(31 downto 0);
signal types    : array(1 to 30) of std_logic_vector(2 downto 0);

signal btnd_prev : std_logic := '0';
signal btnu_prev : std_logic := '0';
signal sw8_prev  : std_logic := '0';
signal sw5_prev  : std_logic := '0';

function get_penalty_time(sw0, sw1, sw2, sw3: std_logic) return unsigned is
begin
    if sw3 = '1' then return C_10MIN;
    elsif sw2 = '1' then return C_5MIN;
    elsif sw1 = '1' then return C_4MIN;
    elsif sw0 = '1' then return C_2MIN;
    else return to_unsigned(0, 32);
    end if;
end function;

function penalty_type(sw0, sw1, sw2, sw3: std_logic) return std_logic_vector is
begin
    if sw3 = '1' then return "011"; -- 10 min
    elsif sw2 = '1' then return "010"; -- 5 min
    elsif sw1 = '1' then return "001"; -- 4 min
    elsif sw0 = '1' then return "000"; -- 2 min
    else return "111"; -- none
    end if;
end function;

begin

-- Clock divider 100MHz to 1ms
process(clk100MHZ)
begin
    if rising_edge(clk100MHZ) then
        if clk_count = C_1MS - 1 then
            clk_count <= (others => '0');
            clk_1ms <= not clk_1ms;
        else
            clk_count <= clk_count + 1;
        end if;
    end if;
end process;

-- Main logic
process(clk_1ms)
    variable a_count : integer;
    variable b_count : integer;
begin
    if rising_edge(clk_1ms) then
        btnd_prev <= BTND;
        btnu_prev <= BTNU;
        sw8_prev  <= SW8;
        sw5_prev  <= SW5;

        if SW13 = '1' then
            for i in 1 to 30 loop
                counters(i) <= (others => '0');
                types(i)    <= "111";
            end loop;
        elsif SW15 = '0' then

            -- New penalty
            if BTNU = '1' and btnu_prev = '0' then
                for i in 1 to 15 loop
                    if types(i) = "111" then
                        counters(i) <= get_penalty_time(SW0, SW1, SW2, SW3);
                        types(i)    <= penalty_type(SW0, SW1, SW2, SW3);
                        exit;
                    end if;
                end loop;
            elsif BTND = '1' and btnd_prev = '0' then
                for i in 16 to 30 loop
                    if types(i) = "111" then
                        counters(i) <= get_penalty_time(SW0, SW1, SW2, SW3);
                        types(i)    <= penalty_type(SW0, SW1, SW2, SW3);
                        exit;
                    end if;
                end loop;
            end if;

            -- Goal - remove shortest penalty
            if SW8 = '1' and sw8_prev = '0' then
                for i in 1 to 15 loop
                    if types(i) /= "111" then
                        if types(i) = "001" then -- 4min shortened
                            counters(i) <= C_2MIN;
                            types(i) <= "000";
                        else
                            counters(i) <= (others => '0');
                            types(i) <= "111";
                        end if;
                        exit;
                    end if;
                end loop;
            elsif SW5 = '1' and sw5_prev = '0' then
                for i in 16 to 30 loop
                    if types(i) /= "111" then
                        if types(i) = "001" then
                            counters(i) <= C_2MIN;
                            types(i) <= "000";
                        else
                            counters(i) <= (others => '0');
                            types(i) <= "111";
                        end if;
                        exit;
                    end if;
                end loop;
            end if;

            -- Timer decrement
            for i in 1 to 30 loop
                if counters(i) > 0 then
                    counters(i) <= counters(i) - 1;
                    if counters(i) = 0 then
                        types(i) <= "111";
                    end if;
                end if;
            end loop;
        end if;

        -- LED update
        a_count := 0;
        b_count := 0;
        for i in 1 to 15 loop
            if types(i) /= "111" then a_count := a_count + 1; end if;
        end loop;
        for i in 16 to 30 loop
            if types(i) /= "111" then b_count := b_count + 1; end if;
        end loop;

        -- Display 5 bits per team (max 15)
        LED1 <= std_logic(to_unsigned(a_count, 5)(4));
        LED2 <= std_logic(to_unsigned(a_count, 5)(3));
        LED3 <= std_logic(to_unsigned(a_count, 5)(2));
        LED4 <= std_logic(to_unsigned(a_count, 5)(1));
        LED5 <= std_logic(to_unsigned(a_count, 5)(0));

        LED10 <= std_logic(to_unsigned(b_count, 5)(4));
        LED11 <= std_logic(to_unsigned(b_count, 5)(3));
        LED12 <= std_logic(to_unsigned(b_count, 5)(2));
        LED13 <= std_logic(to_unsigned(b_count, 5)(1));
        LED14 <= std_logic(to_unsigned(b_count, 5)(0));
    end if;
end process;

end Behavioral;
