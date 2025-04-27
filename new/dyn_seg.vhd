library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dyn_seg is
    Port ( clk : in STD_LOGIC := '0';
           en : in STD_LOGIC := '0';
           CA : out STD_LOGIC := '0';
           CB : out STD_LOGIC := '0'; 
           CC : out STD_LOGIC := '0'; 
           CD : out STD_LOGIC := '0';
           CE : out STD_LOGIC := '0';
           CF : out STD_LOGIC := '0';
           CG : out STD_LOGIC := '0';
           DP: out STD_LOGIC := '0';
           AN : out STD_LOGIC_VECTOR (7 downto 0) := "00000000";
           SGD0 : in STD_LOGIC_VECTOR (7 downto 0);
           SGD1 : in STD_LOGIC_VECTOR (7 downto 0);
           SGD2 : in STD_LOGIC_VECTOR (7 downto 0);
           SGD3 : in STD_LOGIC_VECTOR (7 downto 0);
           SGD4 : in STD_LOGIC_VECTOR (7 downto 0);
           SGD5 : in STD_LOGIC_VECTOR (7 downto 0);
           SGD6 : in STD_LOGIC_VECTOR (7 downto 0);
           SGD7 : in STD_LOGIC_VECTOR (7 downto 0));
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
            CA <= SGD0(7);
            CB <= SGD0(6);
            CC <= SGD0(5);
            CD <= SGD0(4);
            CE <= SGD0(3);
            CF <= SGD0(2);
            CG <= SGD0(1);
            DP <= SGD0(0);
            sig_tc <= "001";
        when "001" =>
            AN <= "10111111"; 
            CA <= SGD1(7);
            CB <= SGD1(6);
            CC <= SGD1(5);
            CD <= SGD1(4);
            CE <= SGD1(3);
            CF <= SGD1(2);
            CG <= SGD1(1);
            DP <= SGD1(0);
            sig_tc <= "010";
        when "010" =>
            AN <= "11011111"; 
            CA <= SGD2(7);
            CB <= SGD2(6);
            CC <= SGD2(5);
            CD <= SGD2(4);
            CE <= SGD2(3);
            CF <= SGD2(2);
            CG <= SGD2(1);
            DP <= SGD2(0);
            sig_tc <= "011";
        when "011" =>
            AN <= "11101111"; 
            CA <= SGD3(7);
            CB <= SGD3(6);
            CC <= SGD3(5);
            CD <= SGD3(4);
            CE <= SGD3(3);
            CF <= SGD3(2);
            CG <= SGD3(1);
            DP <= SGD3(0);
            sig_tc <= "100";
        when "100" =>
            AN <= "11110111"; 
            CA <= SGD4(7);
            CB <= SGD4(6);
            CC <= SGD4(5);
            CD <= SGD4(4);
            CE <= SGD4(3);
            CF <= SGD4(2);
            CG <= SGD4(1);
            DP <= SGD4(0);
            sig_tc <= "101";
        when "101" =>
            AN <= "11111011"; 
            CA <= SGD5(7);
            CB <= SGD5(6);
            CC <= SGD5(5);
            CD <= SGD5(4);
            CE <= SGD5(3);
            CF <= SGD5(2);
            CG <= SGD5(1);
            DP <= SGD5(0);
            sig_tc <= "110";
        when "110" =>
            AN <= "11111101"; 
            CA <= SGD6(7);
            CB <= SGD6(6);
            CC <= SGD6(5);
            CD <= SGD6(4);
            CE <= SGD6(3);
            CF <= SGD6(2);
            CG <= SGD6(1);
            DP <= SGD6(0);
            sig_tc <= "111";
        when "111" =>
            AN <= "11111110"; 
            CA <= SGD7(7);
            CB <= SGD7(6);
            CC <= SGD7(5);
            CD <= SGD7(4);
            CE <= SGD7(3);
            CF <= SGD7(2);
            CG <= SGD7(1);
            DP <= SGD7(0);
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
            DP <= '1';
            sig_tc <= "000";
    end case;
end if;
    end process;
end Behavioral;