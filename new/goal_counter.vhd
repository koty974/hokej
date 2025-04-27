library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity goal_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           SW14 : in STD_LOGIC;
           goal1 : out STD_LOGIC_VECTOR(3 downto 0);
           goal2 : out STD_LOGIC_VECTOR(3 downto 0);
           goal3 : out STD_LOGIC_VECTOR(3 downto 0);
           goal4 : out STD_LOGIC_VECTOR(3 downto 0));
end goal_counter;

architecture Behavioral of goal_counter is
    signal tens1, ones1, tens2, ones2 : integer range 0 to 9 := 0;
    signal BTNL_reg, BTNR_reg : STD_LOGIC := '0';
begin

    process(clk, rst)
    begin
    if rising_edge(clk) then
        if rst = '1' then
            tens1 <= 0;
            ones1 <= 0;
            tens2 <= 0;
            ones2 <= 0;
            BTNL_reg <= '0';
            BTNR_reg <= '0';
        else
            BTNL_reg <= BTNL;
            BTNR_reg <= BTNR;

            if BTNL_reg = '0' and BTNL = '1' then
                if SW14 = '1' then
                    if ones1 > 0 then
                        ones1 <= ones1 - 1;
                    elsif tens1 > 0 then
                        tens1 <= tens1 - 1;
                        ones1 <= 9;
                    end if;
                else
                    if ones1 < 9 then
                        ones1 <= ones1 + 1;
                    else
                        ones1 <= 0;
                        if tens1 < 9 then
                            tens1 <= tens1 + 1;
                        else
                            tens1 <= 0;
                        end if;
                    end if;
                end if;
            end if;

            if BTNR_reg = '0' and BTNR = '1' then
                if SW14 = '1' then
                    if ones2 > 0 then
                        ones2 <= ones2 - 1;
                    elsif tens2 > 0 then
                        tens2 <= tens2 - 1;
                        ones2 <= 9;
                    end if;
                else
                    if ones2 < 9 then
                        ones2 <= ones2 + 1;
                    else
                        ones2 <= 0;
                        if tens2 < 9 then
                            tens2 <= tens2 + 1;
                        else
                            tens2 <= 0;
                        end if;
                    end if;
                end if;
            end if;
        end if;
      end if;
    end process;

    goal1 <= std_logic_vector(to_unsigned(tens1, 4));
    goal2 <= std_logic_vector(to_unsigned(ones1, 4));
    goal3 <= std_logic_vector(to_unsigned(tens2, 4));
    goal4 <= std_logic_vector(to_unsigned(ones2, 4));

end Behavioral;