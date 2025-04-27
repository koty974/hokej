library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity power_play is
    Port (
        clk         : in  STD_LOGIC;
        SW0         : in  STD_LOGIC; -- 2min
        SW1         : in  STD_LOGIC; -- 5min
        BTNU        : in  STD_LOGIC; --tim 1
        BTND        : in  STD_LOGIC; --tim 2
        SW8         : in  STD_LOGIC; -- gol tim 1
        SW5         : in  STD_LOGIC; -- gol tim 2
        SW15        : in  STD_LOGIC; -- zastavenie casu
        SW13        : in  STD_LOGIC; -- celkovy reset
        LED10       : out STD_LOGIC; -- led tim 2
        LED11       : out STD_LOGIC; -- led tim 2
        LED12       : out STD_LOGIC; -- led tim 2
        LED13       : out STD_LOGIC; -- led tim 2
        LED14       : out STD_LOGIC; -- led tim 2
        LED1        : out STD_LOGIC; -- led tim 1
        LED2        : out STD_LOGIC;-- led tim 1
        LED3        : out STD_LOGIC;-- led tim 1
        LED4        : out STD_LOGIC;-- led tim 1
        LED5        : out STD_LOGIC-- led tim 1
    );
end power_play;

architecture Behavioral of power_play is
    use IEEE.STD_LOGIC_UNSIGNED.ALL;
    type unsigned_vector is array (natural range <>) of unsigned(35 downto 0);
    constant MAX_PP : integer := 5;
    constant MAX_2MIN : unsigned(35 downto 0) := x"2C7E8D400";  -- Hexadecimálne pre 12_000_000_000
    constant MAX_5MIN : unsigned(35 downto 0) := x"6FC23AC00";  -- Hexadecimálne pre 30_000_000_000


    -- 2min T1
    signal timer_2min_1 : unsigned_vector(0 to MAX_PP-1) := (others => (others => '0'));
    signal count_2min_1 : integer range 0 to MAX_PP := 0;
    -- 5min T1
    signal timer_5min_1 : unsigned_vector(0 to MAX_PP-1) := (others => (others => '0'));
    signal count_5min_1 : integer range 0 to MAX_PP := 0;

    -- 2min T2
    signal timer_2min_2 : unsigned_vector(0 to MAX_PP-1) := (others => (others => '0'));
    signal count_2min_2 : integer range 0 to MAX_PP := 0;
    -- 5min T2
    signal timer_5min_2 : unsigned_vector(0 to MAX_PP-1) := (others => (others => '0'));
    signal count_5min_2 : integer range 0 to MAX_PP := 0;

    signal btnu_prev, btnd_prev : STD_LOGIC := '0';
    signal sw8_prev, sw5_prev   : STD_LOGIC := '0';
    signal btnu_edge, btnd_edge : STD_LOGIC := '0';
    signal sw8_edge, sw5_edge   : STD_LOGIC := '0';

    signal LED10_i, LED11_i : STD_LOGIC := '1';
    signal LED1_i, LED2_i   : STD_LOGIC := '1';

    signal add_2min_1, add_2min_2 : boolean := false;
    signal add_5min_1, add_5min_2 : boolean := false;
    signal zrus_pp_1, zrus_pp_2  : boolean := false;

begin
    LED1 <= LED1_i; LED2 <= LED2_i; LED3 <= '1'; LED4 <= '1'; LED5 <= '1';
    LED10 <= LED10_i; LED11 <= LED11_i; LED12 <= '1'; LED13 <= '1'; LED14 <= '1';

    -- Hrany
    process(clk)
    begin
        if rising_edge(clk) then
            btnu_edge <= BTNU and not btnu_prev;
            btnd_edge <= BTND and not btnd_prev;
            sw8_edge  <= SW8 and not sw8_prev;
            sw5_edge  <= SW5 and not sw5_prev;
            btnu_prev <= BTNU;
            btnd_prev <= BTND;
            sw8_prev  <= SW8;
            sw5_prev  <= SW5;
        end if;
    end process;

    -- Akcie
    process(clk)
    begin
        if rising_edge(clk) then
            add_2min_1 <= (SW0 = '1' and btnd_edge = '1');
            add_2min_2 <= (SW0 = '1' and btnu_edge = '1');
            add_5min_1 <= (SW1 = '1' and btnd_edge = '1');
            add_5min_2 <= (SW1 = '1' and btnu_edge = '1');
            zrus_pp_1 <= (sw8_edge = '1');
            zrus_pp_2 <= (sw5_edge = '1');
        end if;
    end process;

    -- Hlavný proces
    process(clk)
begin
    if rising_edge(clk) then
        if SW13 = '1' then
            -- Reset všetkého
            count_2min_1 <= 0; timer_2min_1 <= (others => (others => '0'));
            count_2min_2 <= 0; timer_2min_2 <= (others => (others => '0'));
            count_5min_1 <= 0; timer_5min_1 <= (others => (others => '0'));
            count_5min_2 <= 0; timer_5min_2 <= (others => (others => '0'));

        elsif SW15 = '1' then  -- Pozastavenie
            -- Zrušenie 2-minútovej presilovky (len vynulovanie najstaršej)
            if zrus_pp_1 and count_2min_1 > 0 then
                timer_2min_1(count_2min_1 - 1) <= (others => '0');
                count_2min_1 <= count_2min_1 - 1;
            end if;
            if zrus_pp_2 and count_2min_2 > 0 then
                timer_2min_2(count_2min_2 - 1) <= (others => '0');
                count_2min_2 <= count_2min_2 - 1;
            end if;

            -- Pridanie presiloviek
            if add_2min_1 and count_2min_1 < MAX_PP then
                timer_2min_1(count_2min_1) <= (others => '0');
                count_2min_1 <= count_2min_1 + 1;
            end if;
            if add_2min_2 and count_2min_2 < MAX_PP then
                timer_2min_2(count_2min_2) <= (others => '0');
                count_2min_2 <= count_2min_2 + 1;
            end if;
            if add_5min_1 and count_5min_1 < MAX_PP then
                timer_5min_1(count_5min_1) <= (others => '0');
                count_5min_1 <= count_5min_1 + 1;
            end if;
            if add_5min_2 and count_5min_2 < MAX_PP then
                timer_5min_2(count_5min_2) <= (others => '0');
                count_5min_2 <= count_5min_2 + 1;
            end if;

        else  -- Časovanie
            -- 2 MIN TEAM 1
            for i in 0 to MAX_PP-1 loop
                if i < count_2min_1 then
                    timer_2min_1(i) <= timer_2min_1(i) + 1;
                end if;
            end loop;
            if count_2min_1 > 0 and timer_2min_1(0) = MAX_2MIN then
                for i in 0 to MAX_PP-2 loop
                    if i < count_2min_1 - 1 then
                        timer_2min_1(i) <= timer_2min_1(i+1);
                    end if;
                end loop;
                timer_2min_1(count_2min_1-1) <= (others => '0');
                count_2min_1 <= count_2min_1 - 1;
            end if;

            -- 2 MIN TEAM 2
            for i in 0 to MAX_PP-1 loop
                if i < count_2min_2 then
                    timer_2min_2(i) <= timer_2min_2(i) + 1;
                end if;
            end loop;
            if count_2min_2 > 0 and timer_2min_2(0) = MAX_2MIN then
                for i in 0 to MAX_PP-2 loop
                    if i < count_2min_2 - 1 then
                        timer_2min_2(i) <= timer_2min_2(i+1);
                    end if;
                end loop;
                timer_2min_2(count_2min_2-1) <= (others => '0');
                count_2min_2 <= count_2min_2 - 1;
            end if;

            -- 5 MIN TEAM 1
            for i in 0 to MAX_PP-1 loop
                if i < count_5min_1 then
                    timer_5min_1(i) <= timer_5min_1(i) + 1;
                end if;
            end loop;
            if count_5min_1 > 0 and timer_5min_1(0) = MAX_5MIN then
                for i in 0 to MAX_PP-2 loop
                    if i < count_5min_1 - 1 then
                        timer_5min_1(i) <= timer_5min_1(i+1);
                    end if;
                end loop;
                timer_5min_1(count_5min_1-1) <= (others => '0');
                count_5min_1 <= count_5min_1 - 1;
            end if;

            -- 5 MIN TEAM 2
            for i in 0 to MAX_PP-1 loop
                if i < count_5min_2 then
                    timer_5min_2(i) <= timer_5min_2(i) + 1;
                end if;
            end loop;
            if count_5min_2 > 0 and timer_5min_2(0) = MAX_5MIN then
                for i in 0 to MAX_PP-2 loop
                    if i < count_5min_2 - 1 then
                        timer_5min_2(i) <= timer_5min_2(i+1);
                    end if;
                end loop;
                timer_5min_2(count_5min_2-1) <= (others => '0');
                count_5min_2 <= count_5min_2 - 1;
            end if;

        end if;
    end if;
end process;

    -- LED logika
    process(clk)
    begin
        if rising_edge(clk) then
            case count_2min_1 + count_5min_1 is
                when 0 => LED10_i <= '1'; LED11_i <= '1';
                when 1 => LED10_i <= '0'; LED11_i <= '1';
                when others => LED10_i <= '0'; LED11_i <= '0';
            end case;
            case count_2min_2 + count_5min_2 is
                when 0 => LED1_i <= '1'; LED2_i <= '1';
                when 1 => LED1_i <= '0'; LED2_i <= '1';
                when others => LED1_i <= '0'; LED2_i <= '0';
            end case;
        end if;
    end process;

end Behavioral;

