library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dyn_seg is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           SGD0 : in STD_LOGIC_VECTOR (6 downto 0);
           SGD1 : in STD_LOGIC_VECTOR (6 downto 0);
           SGD2 : in STD_LOGIC_VECTOR (6 downto 0);
           SGD3 : in STD_LOGIC_VECTOR (6 downto 0);
           SGD4 : in STD_LOGIC_VECTOR (6 downto 0);
           SGD5 : in STD_LOGIC_VECTOR (6 downto 0);
           SGD6 : in STD_LOGIC_VECTOR (6 downto 0);
           SGD7 : in STD_LOGIC_VECTOR (6 downto 0));
end dyn_seg;

architecture Behavioral of dyn_seg is
    signal sig_tc : std_logic_vector(2 downto 0);

begin
    process (clk, en)
begin
    if rising_edge(clk) and en = '1' then
        case sig_tc is
            when "000" =>
                AN <= "01111111"; 
                CA <= SGD0(6);
                CB <= SGD0(5);
                CC <= SGD0(4);
                CD <= SGD0(3);
                CE <= SGD0(2);
                CF <= SGD0(1);
                CG <= SGD0(0);
                sig_tc <= "001";
            when "001" =>
                AN <= "10111111"; 
                CA <= SGD1(6);
                CB <= SGD1(5);
                CC <= SGD1(4);
                CD <= SGD1(3);
                CE <= SGD1(2);
                CF <= SGD1(1);
                CG <= SGD1(0);
                sig_tc <= "010";
            when "010" =>
                AN <= "11011111"; 
                CA <= SGD2(6);
                CB <= SGD2(5);
                CC <= SGD2(4);
                CD <= SGD2(3);
                CE <= SGD2(2);
                CF <= SGD2(1);
                CG <= SGD2(0);
                sig_tc <= "011";
            when "011" =>
                AN <= "11101111"; 
                CA <= SGD3(6);
                CB <= SGD3(5);
                CC <= SGD3(4);
                CD <= SGD3(3);
                CE <= SGD3(2);
                CF <= SGD3(1);
                CG <= SGD3(0);
                sig_tc <= "100";
            when "100" =>
                AN <= "11110111"; 
                CA <= SGD4(6);
                CB <= SGD4(5);
                CC <= SGD4(4);
                CD <= SGD4(3);
                CE <= SGD4(2);
                CF <= SGD4(1);
                CG <= SGD4(0);
                sig_tc <= "101";
            when "101" =>
                AN <= "11111011"; 
                CA <= SGD5(6);
                CB <= SGD5(5);
                CC <= SGD5(4);
                CD <= SGD5(3);
                CE <= SGD5(2);
                CF <= SGD5(1);
                CG <= SGD5(0);
                sig_tc <= "110";
            when "110" =>
                AN <= "11111101"; 
                CA <= SGD6(6);
                CB <= SGD6(5);
                CC <= SGD6(4);
                CD <= SGD6(3);
                CE <= SGD6(2);
                CF <= SGD6(1);
                CG <= SGD6(0);
                sig_tc <= "111";
            when "111" =>
                AN <= "11111110"; 
                CA <= SGD7(6);
                CB <= SGD7(5);
                CC <= SGD7(4);
                CD <= SGD7(3);
                CE <= SGD7(2);
                CF <= SGD7(1);
                CG <= SGD7(0);
                sig_tc <= "000";
            when others =>
                AN <= "00000000"; 
                CA <= '1';
                CB <= '1';
                CC <= '1';
                CD <= '1';
                CE <= '1';
                CF <= '1';
                CG <= '1';
                sig_tc <= "000";
            end case;
        end if;
    end process;
end Behavioral;