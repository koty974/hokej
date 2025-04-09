----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2025 12:13:32 PM
-- Design Name: 
-- Module Name: dyn_seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
signal sig_data : std_logic_vector(6 downto 0);


begin
process (clk, en)
begin
    if (rising_edge(clk) and en = '1') then
    case sig_tc is
    when "000" =>
         AN <= "10000000"; 
         CA <= SGD0(0);
         CB <= SGD0(1);
         CC <= SGD0(2);
         CD <= SGD0(3);
         CE <= SGD0(4);
         CF <= SGD0(5);
         CG <= SGD0(6);
    when "001" =>
        AN <= "01000000"; 
         CA <= SGD1(0);
         CB <= SGD1(1);
         CC <= SGD1(2);
         CD <= SGD1(3);
         CE <= SGD1(4);
         CF <= SGD1(5);
         CG <= SGD1(6);
     when "010" =>
        AN <= "00100000"; 
         CA <= SGD2(0);
         CB <= SGD2(1);
         CC <= SGD2(2);
         CD <= SGD2(3);
         CE <= SGD2(4);
         CF <= SGD2(5);
         CG <= SGD2(6);
    when "011" =>
        AN <= "00010000"; 
         CA <= SGD3(0);
         CB <= SGD3(1);
         CC <= SGD3(2);
         CD <= SGD3(3);
         CE <= SGD3(4);
         CF <= SGD3(5);
         CG <= SGD3(6);
    when "100" =>
        AN <= "00001000"; 
         CA <= SGD4(0);
         CB <= SGD4(1);
         CC <= SGD4(2);
         CD <= SGD4(3);
         CE <= SGD4(4);
         CF <= SGD4(5);
         CG <= SGD4(6);
    when "101" =>
        AN <= "00000100"; 
         CA <= SGD5(0);
         CB <= SGD5(1);
         CC <= SGD5(2);
         CD <= SGD5(3);
         CE <= SGD5(4);
         CF <= SGD5(5);
         CG <= SGD5(6);
    when "110" =>
        AN <= "00000010"; 
         CA <= SGD6(0);
         CB <= SGD6(1);
         CC <= SGD6(2);
         CD <= SGD6(3);
         CE <= SGD6(4);
         CF <= SGD6(5);
         CG <= SGD6(6);
    when "111" =>
        AN <= "00000001"; 
         CA <= SGD7(0);
         CB <= SGD7(1);
         CC <= SGD7(2);
         CD <= SGD7(3);
         CE <= SGD7(4);
         CF <= SGD7(5);
         CG <= SGD7(6);
         sig_tc <= "000";
        end case;
    end if;
end process;

end Behavioral;
