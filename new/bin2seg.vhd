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
        seg1   : out   std_logic_vector(7 downto 0);  --! Seven active-low segments from A to G
        seg2   : out   std_logic_vector(7 downto 0);  --! Seven active-low segments from A to G
        seg3   : out   std_logic_vector(7 downto 0);  --! Seven active-low segments from A to G
        seg4   : out   std_logic_vector(7 downto 0);  --! Seven active-low segments from A to G
        seg5   : out   std_logic_vector(7 downto 0);  --! Seven active-low segments from A to G
        seg6   : out   std_logic_vector(7 downto 0);  --! Seven active-low segments from A to G
        seg7   : out   std_logic_vector(7 downto 0);  --! Seven active-low segments from A to G
        seg8   : out   std_logic_vector(7 downto 0)  --! Seven active-low segments from A to G
       
    );
end entity bin2seg;

-------------------------------------------------

architecture behavioral of bin2seg is
begin

    p_7seg_decoder : process (clock1,clock2,clock3,clock4,goal1,goal2,goal3,goal4) is
    begin
        case clock1 is
            when x"0" => seg4 <= "00000010";
            when x"1" => seg4 <= "10011110";
            when x"2" => seg4 <= "00100100";
            when x"3" => seg4 <= "00001100";
            when x"4" => seg4 <= "10011000";
            when x"5" => seg4 <= "01001000";
            when x"6" => seg4 <= "01000000";
            when x"7" => seg4 <= "00011110";
            when x"8" => seg4 <= "00000000";
            when x"9" => seg4 <= "00001000";
            when others => seg4 <= "01110000";
        end case;
        
        case clock2 is
            when x"0" => seg3 <= "00000010";
            when x"1" => seg3 <= "10011110";
            when x"2" => seg3 <= "00100100";
            when x"3" => seg3 <= "00001100";
            when x"4" => seg3 <= "10011000";
            when x"5" => seg3 <= "01001000";
            when x"6" => seg3 <= "01000000";
            when x"7" => seg3 <= "00011110";
            when x"8" => seg3 <= "00000000";
            when x"9" => seg3 <= "00001000";
            when others => seg3 <= "01110000";
        end case;

        case clock3 is
            when x"0" => seg2 <= "00000011";
            when x"1" => seg2 <= "10011111";
            when x"2" => seg2 <= "00100101";
            when x"3" => seg2 <= "00001101";
            when x"4" => seg2 <= "10011001";
            when x"5" => seg2 <= "01001001";
            when x"6" => seg2 <= "01000001";
            when x"7" => seg2 <= "00011111";
            when x"8" => seg2 <= "00000001";
            when x"9" => seg2 <= "00001001";
            when others => seg2 <= "01110001";
        end case;

        case clock4 is
            when x"0" => seg1 <= "00000010";
            when x"1" => seg1 <= "10011110";
            when x"2" => seg1 <= "00100100";
            when x"3" => seg1 <= "00001100";
            when x"4" => seg1 <= "10011000";
            when x"5" => seg1 <= "01001000";
            when x"6" => seg1 <= "01000000";
            when x"7" => seg1 <= "00011110";
            when x"8" => seg1 <= "00000000";
            when x"9" => seg1 <= "00001000";
            when others => seg1 <= "01110000";
        end case;

        case goal1 is
            when x"0" => seg5 <= "00000010";
            when x"1" => seg5 <= "10011110";
            when x"2" => seg5 <= "00100100";
            when x"3" => seg5 <= "00001100";
            when x"4" => seg5 <= "10011000";
            when x"5" => seg5 <= "01001000";
            when x"6" => seg5 <= "01000000";
            when x"7" => seg5 <= "00011110";
            when x"8" => seg5 <= "00000000";
            when x"9" => seg5 <= "00001000";
            when others => seg5 <= "01110000";
        end case;

        case goal2 is
            when x"0" => seg6 <= "00000011";
            when x"1" => seg6 <= "10011111";
            when x"2" => seg6 <= "00100101";
            when x"3" => seg6 <= "00001101";
            when x"4" => seg6 <= "10011001";
            when x"5" => seg6 <= "01001001";
            when x"6" => seg6 <= "01000001";
            when x"7" => seg6 <= "00011111";
            when x"8" => seg6 <= "00000001";
            when x"9" => seg6 <= "00001001";
            when others => seg6 <= "01110001";
        end case;

        case goal3 is
            when x"0" => seg7 <= "00000010";
            when x"1" => seg7 <= "10011110";
            when x"2" => seg7 <= "00100100";
            when x"3" => seg7 <= "00001100";
            when x"4" => seg7 <= "10011000";
            when x"5" => seg7 <= "01001000";
            when x"6" => seg7 <= "01000000";
            when x"7" => seg7 <= "00011110";
            when x"8" => seg7 <= "00000000";
            when x"9" => seg7 <= "00001000";
            when others => seg7 <= "01110000";
        end case;

        case goal4 is
            when x"0" => seg8 <= "00000010";
            when x"1" => seg8 <= "10011110";
            when x"2" => seg8 <= "00100100";
            when x"3" => seg8 <= "00001100";
            when x"4" => seg8 <= "10011000";
            when x"5" => seg8 <= "01001000";
            when x"6" => seg8 <= "01000000";
            when x"7" => seg8 <= "00011110";
            when x"8" => seg8 <= "00000000";
            when x"9" => seg8 <= "00001000";
            when others => seg8 <= "01110000";
        end case;

    end process p_7seg_decoder;

end architecture behavioral;

