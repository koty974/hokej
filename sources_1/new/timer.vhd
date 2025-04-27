library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity timer is
    Port (
        BTNC      : in STD_LOGIC;
        SW15      : in STD_LOGIC;
        clk100MHZ : in STD_LOGIC;
        clock1    : out STD_LOGIC_VECTOR (3 downto 0);
        clock2    : out STD_LOGIC_VECTOR (3 downto 0);
        clock3    : out STD_LOGIC_VECTOR (3 downto 0);
        clock4    : out STD_LOGIC_VECTOR (3 downto 0);
        LED16_B   : out STD_LOGIC:= '0';
        LED16_G   : out STD_LOGIC:= '0';
        LED16_R   : out STD_LOGIC:= '0';
        LED17_G   : out STD_LOGIC:= '0';
        LED17_B   : out STD_LOGIC:= '0';
        LED17_R   : out STD_LOGIC:= '0'
    );
end timer;

architecture Behavioral of timer is

    signal sig_pc : std_logic_vector(2 downto 0) := "000";

    signal sig_inclock1 : STD_LOGIC_VECTOR (3 downto 0); -- seconds (ones)
    signal sig_inclock2 : STD_LOGIC_VECTOR (3 downto 0); -- seconds (tens)
    signal sig_inclock3 : STD_LOGIC_VECTOR (3 downto 0); -- minutes (ones)
    signal sig_inclock4 : STD_LOGIC_VECTOR (3 downto 0) := "0010"; -- minutes (tens)
    signal counter : integer := 0; -- counter for 1-second delay
    signal btnc_prev : std_logic := '0'; -- for rising edge detection

begin

    -------------------------------------------------------------------
    -- Combined Button State Machine and Countdown Logic
    -------------------------------------------------------------------
    process(clk100MHZ)
    begin
        if rising_edge(clk100MHZ) then
            -- Save previous state for edge detection
            btnc_prev <= BTNC;

            -- Detect rising edge of BTNC
            if BTNC = '1' and btnc_prev = '0' then
                case sig_pc is
                    when "000" =>
                        sig_inclock1 <= "0000";
                        sig_inclock2 <= "0000";
                        sig_inclock3 <= "0000";
                        sig_inclock4 <= "0010"; -- 20 minutes
                        LED16_B <= '1'; LED16_G <= '0'; LED16_R <= '0';
                        LED17_B <= '0'; LED17_G <= '0'; LED17_R <= '0';
                        sig_pc <= "001";

                    when "001" =>
                        sig_inclock1 <= "0000";
                        sig_inclock2 <= "0000";
                        sig_inclock3 <= "0000";
                        sig_inclock4 <= "0010"; -- 20 minutes
                        LED16_B <= '0'; LED16_G <= '1'; LED16_R <= '0';
                        LED17_B <= '0'; LED17_G <= '0'; LED17_R <= '0';
                        sig_pc <= "010";

                    when "010" =>
                        sig_inclock1 <= "0000";
                        sig_inclock2 <= "0000";
                        sig_inclock3 <= "0000";
                        sig_inclock4 <= "0010"; -- 20 minutes
                        LED16_B <= '0'; LED16_G <= '0'; LED16_R <= '1';
                        LED17_B <= '0'; LED17_G <= '0'; LED17_R <= '0';
                        sig_pc <= "011";

                    when "011" =>
                        sig_inclock1 <= "0000";
                        sig_inclock2 <= "0000";
                        sig_inclock3 <= "0000";
                        sig_inclock4 <= "0001"; -- 10 minutes
                        LED16_B <= '1'; LED16_G <= '0'; LED16_R <= '0';
                        LED17_B <= '1'; LED17_G <= '0'; LED17_R <= '0';
                        sig_pc <= "100";

                    when "100" =>
                        sig_inclock1 <= "0000";
                        sig_inclock2 <= "0000";
                        sig_inclock3 <= "0000";
                        sig_inclock4 <= "0000"; -- 0 minutes
                        LED17_B <= '0'; LED17_G <= '0'; LED17_R <= '1';
                        sig_pc <= "000";

                    when others =>
                        sig_pc <= "000";
                end case;
            end if;

            
           
    -- Increment counter only when SW15 is '0'
            if SW15 = '0' then
                if counter = 100000000 - 1 then
                    counter <= 0;

                    -- Countdown Logic (triggered every 1 second if enabled and not paused)
                    if not (sig_inclock1 = "0000" and sig_inclock2 = "0000" and
                            sig_inclock3 = "0000" and sig_inclock4 = "0000") then

                        if sig_inclock1 > "0000" then
                            sig_inclock1 <= std_logic_vector(unsigned(sig_inclock1) - 1);

                        elsif sig_inclock2 > "0000" then
                            sig_inclock2 <= std_logic_vector(unsigned(sig_inclock2) - 1);
                            sig_inclock1 <= "1001"; -- 9

                        elsif sig_inclock3 > "0000" then
                            sig_inclock3 <= std_logic_vector(unsigned(sig_inclock3) - 1);
                            sig_inclock2 <= "0101"; -- 5
                            sig_inclock1 <= "1001"; -- 9

                        elsif sig_inclock4 > "0000" then
                            sig_inclock4 <= std_logic_vector(unsigned(sig_inclock4) - 1);
                            sig_inclock3 <= "1001"; -- 9
                            sig_inclock2 <= "0101"; -- 5
                            sig_inclock1 <= "1001"; -- 9
                        end if;
                    end if;
                else
                    counter <= counter + 1;
                end if;
            end if;

        end if;
    end process;

    -------------------------------------------------------------------
    -- Output Assignments
    -------------------------------------------------------------------
    clock1 <= sig_inclock1;
    clock2 <= sig_inclock2;
    clock3 <= sig_inclock3;
    clock4 <= sig_inclock4;

end Behavioral;