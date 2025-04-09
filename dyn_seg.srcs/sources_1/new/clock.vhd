----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2025 01:05:07 PM
-- Design Name: 
-- Module Name: clock - Behavioral
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

entity clock is
    Port ( BTNC : in STD_LOGIC;
           SW15 : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           clock1 : out STD_LOGIC_VECTOR (6 downto 0);
           clock2 : out STD_LOGIC_VECTOR (6 downto 0);
           clock3 : out STD_LOGIC_VECTOR (6 downto 0);
           clock4 : out STD_LOGIC_VECTOR (6 downto 0);
           LED16_B : out STD_LOGIC;
           LED16_G : out STD_LOGIC;
           LED16_R : out STD_LOGIC;
           LED17_G : out STD_LOGIC;
           LED17_B : out STD_LOGIC;
           LED17_R : out STD_LOGIC);
end clock;

architecture Behavioral of clock is
signal sig_pc : std_logic_vector(2 downto 0);
signal sig_inclock1 : std_logic_vector(3 downto 0);
signal sig_inclock2 : std_logic_vector(3 downto 0);
signal sig_inclock3 : std_logic_vector(3 downto 0);
signal sig_inclock4 : std_logic_vector(3 downto 0);


begin
process(BTNC)
begin
if (BTNC = '1') then 
    case sig_pc is
    when x"0" => 
    sig_inclock1 <= "0000";
    sig_inclock2 <= "0000";
    sig_inclock3 <= "0000";
    sig_inclock4 <= "0010";
    LED16_B <= '1';
    LED16_G <= '0';
    LED16_R <= '0';
    LED17_B <= '0';
    LED17_G <= '0';
    LED17_R <= '0';
    
    
    when x"1" => 
    sig_inclock1 <= "0000";
    sig_inclock2 <= "0000";
    sig_inclock3 <= "0000";
    sig_inclock4 <= "0010";
    LED16_B <= '0';
    LED16_G <= '1';
    LED16_R <= '0';
    LED17_B <= '0';
    LED17_G <= '0';
    LED17_R <= '0';
    
    when x"2" =>
    sig_inclock1 <= "0000";
    sig_inclock2 <= "0000";
    sig_inclock3 <= "0000";
    sig_inclock4 <= "0010";
    LED16_B <= '0';
    LED16_G <= '0';
    LED16_R <= '1';
    LED17_B <= '0';
    LED17_G <= '0';
    LED17_R <= '0';
    
    when x"3" =>
    sig_inclock1 <= "0000";
    sig_inclock2 <= "0000";
    sig_inclock3 <= "0000";
    sig_inclock4 <= "0001";
    LED16_B <= '1';
    LED16_G <= '0';
    LED16_R <= '0';
    LED17_B <= '1';
    LED17_G <= '0';
    LED17_R <= '0';
    
    when x"4" =>
    sig_inclock1 <= "0000";
    sig_inclock2 <= "0000";
    sig_inclock3 <= "0000";
    sig_inclock4 <= "0000";
    LED16_B <= '0';
    LED16_G <= '0';
    LED16_R <= '1';
    LED17_B <= '0';
    LED17_G <= '0';
    LED17_R <= '1';
    sig_pc <= x"0";
    
    




end case;
end if;
end process;

end Behavioral;
