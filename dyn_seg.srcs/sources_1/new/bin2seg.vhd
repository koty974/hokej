-------------------------------------------------
--! @brief One-digit 7-segment display decoder
--! @version 1.3
--! @copyright (c) 2018-2025 Tomas Fryza, MIT license
--!
--! This VHDL file represents a binary-to-seven-segment decoder
--! for a one-digit display with Common Anode configuration
--! (active-low). The decoder defines 16 hexadecimal symbols:
--! `0, 1, ..., 9, A, b, C, d, E, F`. All segments are turned
--! off when `clear` signal is high. Note that Decimal Point
--! functionality is not implemented.
--!
--! Developed using TerosHDL, Vivado 2020.2, and EDA Playground.
--! Tested on Nexys A7-50T board and xc7a50ticsg324-1L FPGA.
-------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity bin2seg is
    port (
        clock1   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol
        clock2   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol
        clock3   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol
        clock4   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol
        goal1   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol
        goal2   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol
        goal3   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol
        goal4   : in    std_logic_vector(3 downto 0); --! Binary representation of one hexadecimal symbol     
        seg1   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
        seg2   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
        seg3   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
        seg4   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
        seg5   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
        seg6   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
        seg7   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
        seg8   : out   std_logic_vector(6 downto 0)  --! Seven active-low segments from A to G
       
    );
end entity bin2seg;

-------------------------------------------------

architecture behavioral of bin2seg is
begin

    --! This combinational process decodes binary input
    --! `bin` into 7-segment display output `seg` for a
    --! Common Anode configuration. When either `bin` or
    --! `clear` changes, the process is triggered. Each
    --! bit in `seg` represents a segment from A to G.
    --! The display is cleared if `clear` is set to 1.
    p_7seg_decoder : process (clock1,clock2,clock3,clock4,goal1,goal2,goal3,goal4) is
    begin
            case clock1 is
                when x"0" =>
                    seg1 <= "0000001";

                when x"1" =>
                    seg1 <= "1001111";

                when x"2" =>
                    seg1 <= "0010010";

                when x"3" =>
                    seg1 <= "0000110";

                when x"4" =>
                    seg1 <= "1001100";

                when x"5" =>
                    seg1 <= "0100100";

                when x"6" =>
                    seg1 <= "0100000";

                when x"7" =>
                    seg1 <= "0001111";

                when x"8" =>
                    seg1 <= "0000000";

                when x"9" =>
                    seg1 <= "0000100";
                when others =>
                    seg1 <= "0111000";
            end case;
case clock2 is
                when x"0" =>
                    seg2 <= "0000001";

                when x"1" =>
                    seg2 <= "1001111";

                when x"2" =>
                    seg2 <= "0010010";

                when x"3" =>
                    seg2 <= "0000110";

                when x"4" =>
                    seg2 <= "1001100";

                when x"5" =>
                    seg2 <= "0100100";

                when x"6" =>
                    seg2 <= "0100000";

                when x"7" =>
                    seg2 <= "0001111";

                when x"8" =>
                    seg2 <= "0000000";

                when x"9" =>
                    seg2 <= "0000100";
                when others =>
                    seg2 <= "0111000";
            end case;
            
case clock3 is
                when x"0" =>
                    seg3 <= "0000001";

                when x"1" =>
                    seg3 <= "1001111";

                when x"2" =>
                    seg3 <= "0010010";

                when x"3" =>
                    seg3 <= "0000110";

                when x"4" =>
                    seg3 <= "1001100";

                when x"5" =>
                    seg3 <= "0100100";

                when x"6" =>
                    seg3 <= "0100000";

                when x"7" =>
                    seg3 <= "0001111";

                when x"8" =>
                    seg3 <= "0000000";

                when x"9" =>
                    seg3 <= "0000100";
                when others =>
                    seg3 <= "0111000";
            end case;
            
case clock4 is
                when x"0" =>
                    seg4 <= "0000001";

                when x"1" =>
                    seg4 <= "1001111";

                when x"2" =>
                    seg4 <= "0010010";

                when x"3" =>
                    seg4 <= "0000110";

                when x"4" =>
                    seg4 <= "1001100";

                when x"5" =>
                    seg4 <= "0100100";

                when x"6" =>
                    seg4 <= "0100000";

                when x"7" =>
                    seg4 <= "0001111";

                when x"8" =>
                    seg4 <= "0000000";

                when x"9" =>
                    seg4 <= "0000100";
                when others =>
                    seg4 <= "0111000";
            end case;
            
case goal1 is
                when x"0" =>
                    seg5 <= "0000001";

                when x"1" =>
                    seg5 <= "1001111";

                when x"2" =>
                    seg5 <= "0010010";

                when x"3" =>
                    seg5 <= "0000110";

                when x"4" =>
                    seg5 <= "1001100";

                when x"5" =>
                    seg5 <= "0100100";

                when x"6" =>
                    seg5 <= "0100000";

                when x"7" =>
                    seg5 <= "0001111";

                when x"8" =>
                    seg5 <= "0000000";

                when x"9" =>
                    seg5 <= "0000100";
                when others =>
                    seg3 <= "0111000";
            end case;
            
case goal2 is
                when x"0" =>
                    seg6 <= "0000001";

                when x"1" =>
                    seg6 <= "1001111";

                when x"2" =>
                    seg6 <= "0010010";

                when x"3" =>
                    seg6 <= "0000110";

                when x"4" =>
                    seg6 <= "1001100";

                when x"5" =>
                    seg6 <= "0100100";

                when x"6" =>
                    seg6 <= "0100000";

                when x"7" =>
                    seg6 <= "0001111";

                when x"8" =>
                    seg6 <= "0000000";

                when x"9" =>
                    seg6 <= "0000100";
                when others =>
                    seg6 <= "0111000";
            end case;
            
case goal3 is
                when x"0" =>
                    seg7 <= "0000001";

                when x"1" =>
                    seg7 <= "1001111";

                when x"2" =>
                    seg7 <= "0010010";

                when x"3" =>
                    seg7 <= "0000110";

                when x"4" =>
                    seg7 <= "1001100";

                when x"5" =>
                    seg7 <= "0100100";

                when x"6" =>
                    seg7 <= "0100000";

                when x"7" =>
                    seg7 <= "0001111";

                when x"8" =>
                    seg7 <= "0000000";

                when x"9" =>
                    seg7 <= "0000100";
                when others =>
                    seg7 <= "0111000";
            end case;
            
case goal4 is
                when x"0" =>
                    seg8 <= "0000001";

                when x"1" =>
                    seg8 <= "1001111";

                when x"2" =>
                    seg8 <= "0010010";

                when x"3" =>
                    seg8 <= "0000110";

                when x"4" =>
                    seg8 <= "1001100";

                when x"5" =>
                    seg8 <= "0100100";

                when x"6" =>
                    seg8 <= "0100000";

                when x"7" =>
                    seg8 <= "0001111";

                when x"8" =>
                    seg8 <= "0000000";

                when x"9" =>
                    seg8 <= "0000100";
                when others =>
                    seg8 <= "0111000";
            end case;
            


    end process p_7seg_decoder;

end architecture behavioral;